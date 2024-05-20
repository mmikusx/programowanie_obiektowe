import Fluent
import Vapor

struct CategoryController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let categories = routes.grouped("categories")
        categories.get(use: index)
        categories.post(use: create)
        categories.group(":categoryID") { category in
            category.delete(use: delete)
            category.put(use: update)
            category.get(use: show)
        }
    }

    func index(req: Request) throws -> EventLoopFuture<[Category]> {
        return Category.query(on: req.db).all()
    }

    func create(req: Request) throws -> EventLoopFuture<Category> {
        let category = try req.content.decode(Category.self)
        return category.save(on: req.db).map { category }
    }

    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        return Category.find(req.parameters.get("categoryID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: req.db) }
            .transform(to: .ok)
    }

    func update(req: Request) throws -> EventLoopFuture<Category> {
        let updatedCategory = try req.content.decode(Category.self)
        return Category.find(req.parameters.get("categoryID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { category in
                category.name = updatedCategory.name
                return category.save(on: req.db).map { category }
            }
    }

    func show(req: Request) throws -> EventLoopFuture<Category> {
        return Category.find(req.parameters.get("categoryID"), on: req.db)
            .unwrap(or: Abort(.notFound))
    }
}
