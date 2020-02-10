///**
/**

Created by: Jefry Eko Mulya on 11/02/20
https://github.com/jefrydagucci
Copyright (c) 2020 DAGUCI

*/

import Fluent

struct CreateReminder: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(Reminder.schema)
            .field("id", .int, .identifier(auto: true))
            .field("title", .string, .required)
            .field("userID", .int, .references(User.schema, "id"))
            .create()
    }
    
//    func prepare(on database: Database) -> EventLoopFuture<Void> {
//        return database.schema(Reminder.schema)
//            .field(Reminder.key(for: \.$id), .int, .identifier(auto: true))
//            .field(Reminder.key(for: \.$title), .string, .required)
//            .field(Reminder.key(for: \.$user), .int, .required)
//            .create()
//    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(Reminder.schema).delete()
    }
}

