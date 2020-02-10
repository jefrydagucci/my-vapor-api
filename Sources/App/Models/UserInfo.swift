///**
/**

Created by: Jefry Eko Mulya on 11/02/20
https://github.com/jefrydagucci
Copyright (c) 2020 DAGUCI

*/

import Vapor
 
struct UserInfo: Content {
    let name: String
    let age: Int
}

struct UserMessage: Content {
    let message: String
}
