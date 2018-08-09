//
//  ShowProductViewController.swift
//  t.sasin
//
//  Created by Timur Sasin on 31/07/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

import UIKit

class ShowProductViewController: UIViewController {

    var productId: Int?
    
    let requestFactory = RequestFactorySingleton.instance.requestFactory
    
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let id = self.productId else { return }
        
        let product = requestFactory.makeSingleProductRequestFactory()
        
        product.getSingleProduct(idProduct: id) { response in
            switch response.result {
            case .success(let item):
                DispatchQueue.main.async {
                    self.productName.text = item.product_name
                    self.productPrice.text = String(item.product_price) + " rub."
                    self.productDescription.text = String(item.product_description)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }

}
