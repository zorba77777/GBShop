//
//  LoginFormController.swift
//  Weather
//
//  Created by Timur Sasin on 17/01/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

import UIKit
import Foundation
import Crashlytics


class LoginFormController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var loginInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    
    static var id: Int?
    
    let requestFactory = RequestFactorySingleton.instance.requestFactory
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
       
        scrollView?.addGestureRecognizer(hideKeyboardGesture)
    }
    
    
    @objc func keyboardWasShown(notification: Notification) {
       
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIKeyboardFrameEndUserInfoKey) as!  NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0)
        
        self.scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    @objc func keyboardWillBeHidden(notification: Notification) {
        
        let contentInsets = UIEdgeInsets.zero
        scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name:
            NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector:
            #selector(self.keyboardWillBeHidden(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow,
                                                  object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide,
                                                  object: nil)
    }
    
    @objc func hideKeyboard() {
        self.scrollView?.endEditing(true)
    }
    
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        checkUserData { result in
            if result {
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "showCatalogThroughSign-in", sender: self)
                    Answers.logLogin(withMethod: "Digits",
                                               success: true,
                                               customAttributes: [:])
                }
            } else {
                DispatchQueue.main.async {
                    self.showLoginError()
                    Answers.logLogin(withMethod: "Digits",
                                     success: false,
                                     customAttributes: [:])
                }
            }
        }
    }
    
    func checkUserData(completion: @escaping (Bool) -> Void) {
        let login = loginInput.text!
        let password = passwordInput.text!

        let auth = requestFactory.makeAuthRequestFactory()
        auth.login(userName: login, password: password) {
            response in
            switch response.result {
            case .success(let result):
                LoginFormController.id = result.user.id
                completion(true)
            case .failure(let error):
                print(error.localizedDescription)
                completion(false)
            }
        }
    }
    
    func showLoginError() {
        
        let alert = UIAlertController(title: "Signin was unsuccessful", message: "User data is incorrect", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }


}
