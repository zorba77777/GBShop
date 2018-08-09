//
//  CurrentSessionDataSingleton.swift
//  t.sasin
//
//  Created by Timur Sasin on 26/07/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

import Foundation

class RequestFactorySingleton {
    
    static let instance = RequestFactorySingleton()
    
    var requestFactory: RequestFactory
    
    private init() {
        self.requestFactory = RequestFactory()
    }
    
}
