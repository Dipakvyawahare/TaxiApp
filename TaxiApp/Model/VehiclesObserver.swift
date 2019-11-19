//
//  VehiclesObserver.swift
//  TaxiApp
//
//  Created by Dipak V. Vyawahare on 18/11/19.
//  Copyright © 2019 MyOrganization. All rights reserved.
//

import Foundation

class VehicleObserver: NSObject {
    
    typealias CompletionHandler = (() -> Void)
    
    var value: [Vehicle] {
        didSet {
            self.notify()
        }
    }
    
    private var observers = [String: CompletionHandler]()
    
    init(_ value: [Vehicle]) {
        self.value = value
    }
    
    @objc public func addObserver(_ observer: NSObject,
                                  completionHandler: @escaping CompletionHandler) {
        observers[observer.description] = completionHandler
    }
    
    @objc public func addAndNotify(observer: NSObject,
                                   completionHandler: @escaping CompletionHandler) {
        self.addObserver(observer,
                         completionHandler: completionHandler)
        self.notify()
    }
    
    private func notify() {
        observers.forEach({ $0.value() })
    }
    
    deinit {
        observers.removeAll()
    }
}
