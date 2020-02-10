///**
/**

Created by: Jefry Eko Mulya on 10/02/20
https://github.com/jefrydagucci
Copyright (c) 2020 DAGUCI

*/

import Fluent
import Vapor

struct UserController: RouteCollection {
    
    /*
     POST http://localhost:8080/api/users/
     {
     "name" : "Jefry",
     "username": "jefrydagucci"
     }
     */
    func boot(routes: RoutesBuilder) throws {
        let userRoutes = routes.grouped("api", "users")
        userRoutes.post(use: create)
    }
    
    func create(req: Request) throws -> EventLoopFuture<User> {
        let user = try req.content.decode(User.self)
        return user.save(on: req.db).map { user }
    }
}

