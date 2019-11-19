//
//  ErrorResult.swift
//  TaxiApp
//
//  Created by Dipak V. Vyawahare on 18/11/19.
//  Copyright © 2019 MyOrganization. All rights reserved.
//

import Foundation
@objc enum ErrorCase: Int {
    case network
    case parser
    case custom
}

@objcMembers
class ErrorResult: NSObject, Error {
    var type: ErrorCase
    var message = ""
    init(_ type: ErrorCase, _ message: String) {
        self.type = type
        self.message = message
    }
}
