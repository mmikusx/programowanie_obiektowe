import Fluent
import FluentSQLiteDriver
import Vapor
import Leaf

public func configure(_ app: Application) throws {
    app.databases.use(.sqlite(.file("db.sqlite")), as: .sqlite)
    
    app.views.use(.leaf)

    app.migrations.add(CreateCategory())
    app.migrations.add(CreateProduct())

    try app.autoMigrate().wait()

    try routes(app)
}
