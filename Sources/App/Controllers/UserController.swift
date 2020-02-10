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
        userRoutes.delete(":userID", use: deleteHandler)
        userRoutes.put(":userID", use: updateHandler)
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
    
    /*
     DELETE http://localhost:8080/api/users/1
     */
    func deleteHandler(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        return try getHandler(req: req)
            .flatMap { $0.delete(on: req.db) }
            .map { .ok }
    }
    
    /*
     PUT {{host}}/api/users/1
     {
     "name" : "Jefry",
     "username": "jefrydagucci"
     }
     */
    func updateHandler(req: Request) throws -> EventLoopFuture<User> {
        let updatedUser = try req.content.decode(User.self)
        return try getHandler(req: req)
            .flatMap { user in
                user.name = updatedUser.name
                user.username = updatedUser.name
                return user.save(on: req.db).map { user }
        }
    }
}

