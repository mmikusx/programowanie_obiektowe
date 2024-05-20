import Vapor

func routes(_ app: Application) throws {
    let categoryController = CategoryController()
    try app.register(collection: categoryController)
    
    let productController = ProductController()
    try app.register(collection: productController)
}
