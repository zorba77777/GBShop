//
//  RegistrationController.swift
//  t.sasin
//
//  Created by Timur Sasin on 24/07/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

import UIKit
import Crashlytics

class RegistrationController: UIViewController {
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var gender: UITextField!
    @IBOutlet weak var creditCard: UITextField!
    @IBOutlet weak var bio: UITextField!
    
    let requestFactory = RequestFactorySingleton.instance.requestFactory
    
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        checkUserData { result in
            if result {
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "showCatalogThroughSign-up", sender: self)
                    Answers.logSignUp(withMethod: "Digits",
                                                success: true,
                                                customAttributes: [:])
                }
            } else {
                DispatchQueue.main.async {
                    self.showSignUpError()
                    Answers.logSignUp(withMethod: "Digits",
                                                success: false,
                                                customAttributes: [:])
                }
            }
        }
    }
    
    func checkUserData(completion: @escaping (Bool) -> Void) {
        
        let registration = requestFactory.makeRegistrRequestFactory()
        let id = arc4random_uniform(42)
        LoginFormController.id = Int(id)
        
        registration.register(
            registerDTO: RegisterDTO(id: String(id),
                                     username: self.name.text!,
                                     password: self.password.text!,
                                     email: self.email.text!,
                                     gender: self.gender.text!,
                                     creditCard: self.creditCard.text!,
                                     bio: self.bio.text!)
        ) {
            response in
            switch response.result {
            case .success:
                completion(true)
            case .failure(let error):
                print(error.localizedDescription)
                completion(false)
            }
        }
    }
    
    func showSignUpError() {
        
        let alter = UIAlertController(title: "Signup was unsuccessful", message: "User data is incorrect", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        alter.addAction(action)
        
        present(alter, animated: true, completion: nil)
    }
    
}
