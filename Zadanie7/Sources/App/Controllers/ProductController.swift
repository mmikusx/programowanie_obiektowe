import Fluent
import Vapor

struct ProductInput: Content {
    var name: String
    var price: Double
    var categoryID: UUID
}

struct ProductController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let products = routes.grouped("products")
        products.get(use: index)
        products.post(use: create)
        products.group(":productID") { product in
            product.delete(use: delete)
            product.put(use: update)
            product.get(use: show)
        }
    }

    func index(req: Request) throws -> EventLoopFuture<[Product]> {
        return Product.query(on: req.db).all()
    }

    func create(req: Request) throws -> EventLoopFuture<Product> {
        let productInput = try req.content.decode(ProductInput.self)
        let product = Product(name: productInput.name, price: productInput.price, categoryID: productInput.categoryID)
        return product.save(on: req.db).map { product }
    }

    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        return Product.find(req.parameters.get("productID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: req.db) }
            .transform(to: .ok)
    }

    func update(req: Request) throws -> EventLoopFuture<Product> {
        let updatedProduct = try req.content.decode(ProductInput.self)
        return Product.find(req.parameters.get("productID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { product in
                product.name = updatedProduct.name
                product.price = updatedProduct.price
                product.$category.id = updatedProduct.categoryID
                return product.save(on: req.db).map { product }
            }
    }

    func show(req: Request) throws -> EventLoopFuture<Product> {
        return Product.find(req.parameters.get("productID"), on: req.db)
            .unwrap(or: Abort(.notFound))
    }
}
