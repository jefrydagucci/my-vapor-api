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
    /*
    GET {{host}}/hello/:name
    */
    app.get("hello", ":name") { req -> String in
        guard let name = req.parameters.get("name", as: String.self) else {
            throw Abort(.badRequest)
        }
        return "Hello \(name)"
    }
    /*
    Accept and return JSON
    POST {{host}}/user-info/
    {
       "name" : "Jefry",
       "age": 17
    }
    */
    app.post("user-info") { (req) -> UserMessage in
        let user = try req.content.decode(UserInfo.self)
        let message = "Hello \(user.name), you are \(user.age)"
        return UserMessage(message: message)
    }

    let todoController = TodoController()
    app.get("todos", use: todoController.index)
    app.post("todos", use: todoController.create)
    app.on(.DELETE, "todos", ":todoID", use: todoController.delete)
    
    try app.register(collection: UserController())
}
