//
//  CatalogTableViewController.swift
//  t.sasin
//
//  Created by Timur Sasin on 26/07/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

import UIKit
import Crashlytics

class CatalogTableViewController: UITableViewController {
    
    let requestFactory = RequestFactorySingleton.instance.requestFactory
    
    var catalog: [CatalogItem] = [CatalogItem]()
    
    let identifier = "productCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logout))
        
        let catalogFactory = self.requestFactory.makeCatalogRequestFactory()
        
        catalogFactory.getCatalog(pageNumber: 1, idCategory: 1) {
            [unowned self]
            response in
            switch response.result {
            
            case .success(let products):
               
                for product in products {
                    self.catalog.append(
                        CatalogItem(id: product.id_product,
                                    name: product.product_name,
                                    price: product.price)
                    )
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
        Answers.logContentView(withName: "Product catalog",
                               contentType: "Product catalog",
                               contentId: "",
                               customAttributes: [:])
        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return catalog.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? ProductTableViewCell
        let item = self.catalog[indexPath.row]
        
        cell?.id.text = String(item.id)
        cell?.name.text = item.name
        cell?.price.text = String(item.price)
        
        cell?.showProduct.tag = item.id
        cell?.addToBasket.tag = item.id
        
        cell?.showProduct.addTarget(self, action: #selector(CatalogTableViewController.showProduct(_:)), for: .touchUpInside)
        cell?.addToBasket.addTarget(self, action: #selector(CatalogTableViewController.addToBasket(_:)), for: .touchUpInside)

        guard let newCell = cell else {
            print("Something went wrong with productTableViewCell return")
            return UITableViewCell()
        }
        
        return newCell
    }
    
    @objc func showProduct(_ sender: UIButton!) {
        self.performSegue(withIdentifier: "showProduct", sender: sender)
        
        guard let button = sender else { return }
        Answers.logContentView(withName: "Product",
                               contentType: "Product",
                               contentId: String(button.tag),
                               customAttributes: [:])
    }
    
    @objc func addToBasket(_ sender: UIButton!) {
        
        guard let button = sender else {
            print("Something went wrong with addToBasket function sender")
            return
        }
        
        let addToBasketFactory = self.requestFactory.makeAddToBasketRequestFactory()
        
        addToBasketFactory.addToBasket(id: button.tag, quantity: 1) {
            response in
            switch response.result {
            case .success( _):
                print("Product added to basket")
                Answers.logAddToCart(withPrice: 0,
                                              currency: "RUB",
                                              itemName: "",
                                              itemType: "",
                                              itemId: "",
                                              customAttributes: [:])
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "showProduct" {
           
            guard let button = sender as? UIButton else {
                print("Something went wrong with sender of showProduct segue")
                return
            }
            
            guard let destController = segue.destination as? ShowProductViewController else {
                print("Something went wrong with destination of showProduct segue")
                return
            }
            
            destController.productId = button.tag

        }
    }
    
    @objc func logout() {
        LoginFormController.id = nil
        self.dismiss(animated: true, completion: {})
        self.navigationController?.popToRootViewController(animated: true)
        
        Answers.logCustomEvent(withName: "logout",
                                       customAttributes: [:])
    }

}
