//
//  BasketTableViewController.swift
//  t.sasin
//
//  Created by Timur Sasin on 02/08/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

import UIKit
import Crashlytics

class BasketTableViewController: UITableViewController {
    
    @IBOutlet weak var header: UILabel!
    
    let requestFactory = RequestFactorySingleton.instance.requestFactory
    
    var basket: [BasketItem] = [BasketItem]()
    
    let identifier = "basketItemCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getBasketFromServer()
        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return basket.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? BasketItemTableViewCell
        let item = self.basket[indexPath.row]
        
        cell?.id.text = String(item.id)
        cell?.name.text = item.name
        cell?.price.text = String(item.price)
        cell?.quantity.text = String(item.quantity)
        cell?.removeFromBasket.tag = item.id
        
        cell?.removeFromBasket.addTarget(self, action: #selector(BasketTableViewController.removeFromBasket(_:)), for: .touchUpInside)
        
        guard let newCell = cell else {
            print("Something went wrong with BasketItemTableViewCell return")
            return UITableViewCell()
        }
        
        return newCell
    }
    
    @objc func removeFromBasket(_ sender: UIButton!) {
        
        guard let button = sender else {
            print("Something went wrong with addToBasket function sender")
            return
        }
        
        let removeFromBasketFactory = self.requestFactory.makeDeleteFromBasketRequestFactory()
        
        removeFromBasketFactory.deleteFromBasket(id: button.tag) {
            response in
            switch response.result {
            case .success( _):
                
                self.basket = [BasketItem]()
                self.getBasketFromServer()
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
                Answers.logCustomEvent(withName: "Remove good from cart",
                                       customAttributes: [:])
                
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
    
    func getBasketFromServer() {
        
        let basketFactory = self.requestFactory.makeGetBasketRequestFactory()
        
        guard let id = LoginFormController.id else {return}
        
        basketFactory.getBasket(id: id) {
            [unowned self]
            response in
            switch response.result {
                
            case .success(let result):
                
                for item in result.contents {
                    self.basket.append(
                        BasketItem(
                            id: item.id_product,
                            name: item.product_name,
                            price: item.price,
                            quantity: item.quantity
                        )
                    )
                }
                
                DispatchQueue.main.async {
                    self.header.text = "Amount " + String(result.countGoods) + " Total price " + String(result.amount)
                    self.tableView.reloadData()
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
    
    
    @IBAction func buy(_ sender: UIButton) {
        Answers.logPurchase(withPrice: 0,
                                     currency: "RUB",
                                     success: true,
                                     itemName: "",
                                     itemType: "",
                                     itemId: "",
                                     customAttributes: [:])
    }
    
}
