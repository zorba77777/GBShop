//
//  ChangePersDataRequestFactory.swift
//  t.sasin
//
//  Created by Timur Sasin on 06/07/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

/**
 * Interface which must be implemented by class that sending request on server to get single product by its id
 */
import Alamofire

protocol ChangePersDataRequestFactory {
    
    func changePersData(
        changePersDataDTO: ChangePersDataDTO,
        completionHandler: @escaping (DataResponse<ChangePersDataResult>) -> Void)
}
