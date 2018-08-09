//
//  ReviewViewController.swift
//  t.sasin
//
//  Created by Timur Sasin on 06/08/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

import UIKit
import Crashlytics

class ReviewViewController: UIViewController {

    @IBOutlet weak var reviewText: UITextView!
    
    let requestFactory = RequestFactorySingleton.instance.requestFactory

    @IBAction func sendReview(_ sender: UIButton) {
        
        let addRewievFactory = self.requestFactory.makeAddReviewRequestFactory()
        guard let id = LoginFormController.id else {return}
        guard let text = reviewText.text else {return}
        
        addRewievFactory.addReview(id: id, text: text) {
            response in
            switch response.result {
            case .success( _):
                print("Review added")
                Answers.logCustomEvent(withName: "Add review",
                                       customAttributes: [:])
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

}
