///**
/**

Created by: Jefry Eko Mulya on 11/02/20
https://github.com/jefrydagucci
Copyright (c) 2020 DAGUCI

*/

import Fluent
import Vapor

struct ReminderController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        let reminderRoutes = routes.grouped("api", "reminders")
        reminderRoutes.post(use: create)
        reminderRoutes.get(use: getAll)
    }
    
    /*
    POST {{host}}/api/reminders/
    */
    func create(req: Request) throws -> EventLoopFuture<Reminder> {
        let reminder = try req.content.decode(Reminder.self)
        return reminder.save(on: req.db).map { reminder }
    }
    
    /*
     GET {{host}}/api/reminders/
     */
    func getAll(req: Request) throws -> EventLoopFuture<[Reminder]> {
        return Reminder.query(on: req.db).all()
    }
}


