import Fluent
import FluentSQLiteDriver
import Vapor

// Called before your application initializes.
public func configure(_ app: Application) throws {
    // Serves files from `Public/` directory
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    // Configure SQLite database
    app.databases.use(.sqlite(.file("db.sqlite")), as: .sqlite)
//    app.databases.use(.sqlite(.memory), as: .sqlite)

    // Configure migrations
    app.migrations.add(CreateTodo())
    app.migrations.add(CreateUser())
    
    try app.autoMigrate().wait()
    try routes(app)
}
