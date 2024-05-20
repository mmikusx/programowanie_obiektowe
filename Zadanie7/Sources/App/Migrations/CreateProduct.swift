import Fluent

struct CreateProduct: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("products")
            .id()
            .field("name", .string, .required)
            .field("price", .double, .required)
            .field("category_id", .uuid, .required, .references("categories", "id"))
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("products").delete()
    }
}
