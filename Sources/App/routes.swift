import Fluent
import Vapor

func routes(_ app: Application) throws {
    /*
     GET {{host}}/
     */
    app.get { req in
        return "It works!"
    }
    /*
    GET {{host}}/hello
    */
    app.get("hello") { req in
        return "Hello, world!"
    }
    /*
    GET {{host}}/hello/ovo
    */
    app.get("hello", "ovo") { req in
        return "Hello, OVO!"
    }

    let todoController = TodoController()
    app.get("todos", use: todoController.index)
    app.post("todos", use: todoController.create)
    app.on(.DELETE, "todos", ":todoID", use: todoController.delete)
}
