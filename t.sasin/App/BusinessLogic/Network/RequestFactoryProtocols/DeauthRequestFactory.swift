//
//  DeauthRequestFactory.swift
//  t.sasin
//
//  Created by Timur Sasin on 05/07/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

/**
 * Interface which must be implemented by class that sending authorization request on server
 */
import Alamofire

protocol DeauthRequestFactory {
    
    func logout(
        id: String,
        completionHandler: @escaping
        (DataResponse<LogoutResult>) -> Void
    )
}
