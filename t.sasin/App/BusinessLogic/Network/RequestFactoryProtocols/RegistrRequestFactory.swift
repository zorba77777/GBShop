//
//  RegistrRequestFactory.swift
//  t.sasin
//
//  Created by Timur Sasin on 06/07/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

/**
 * Interface which must be implemented by class that sending registration request on server
 */
import Alamofire

protocol RegistrRequestFactory {
    
    func register(
        registerDTO: RegisterDTO,
        completionHandler: @escaping (DataResponse<RegistrResult>) -> Void)
}
