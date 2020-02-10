///**
/**

Created by: Jefry Eko Mulya on 10/02/20
https://github.com/jefrydagucci
Copyright (c) 2020 DAGUCI

*/

import Fluent
import Vapor

struct UserController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        let userRoutes = routes.grouped("api", "users")
        userRoutes.post(use: create)
        userRoutes.get(use: getAll)
        userRoutes.get(":userID", use: getHandler)
    }
    
    /*
    POST http://localhost:8080/api/users/
    {
    "name" : "Jefry",
    "username": "jefrydagucci"
    }
    */
    func create(req: Request) throws -> EventLoopFuture<User> {
        let user = try req.content.decode(User.self)
        return user.save(on: req.db).map { user }
    }
    
    /*
     GET {{host}}/api/users/
     [
     {
     "name" : "Jefry",
     "username": "jefrydagucci"
     },
     {
     "name" : "Jefry2",
     "username": "jefrydagucci2"
     }
     ]
     */
    func getAll(req: Request) throws -> EventLoopFuture<[User]> {
        return User.query(on: req.db).all()
    }
    
    /*
     GET {{host}}/api/users/1
     {
     "name" : "Jefry",
     "username": "jefrydagucci"
     }
     */
    func getHandler(req: Request) throws -> EventLoopFuture<User> {
        return User.find(req.parameters.get("userID"), on: req.db)
            .unwrap(or: Abort(.notFound))
    }
}

