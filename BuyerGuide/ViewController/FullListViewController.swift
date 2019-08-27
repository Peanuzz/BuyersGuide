//
//  FullListViewController.swift
//  BuyerGuide
//
//  Created by Peanuz on 27/8/2562 BE.
//  Copyright © 2562 SCB. All rights reserved.
//

import UIKit

class FullListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var purplemodels: [PurpleModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        getPurpleModel()

        // Do any additional setup after loading the view.
    }
    
    func getPurpleModel() {
        APIManager.shared.getPurpleModel() { [weak self] result in
            switch result {
            case .success(let product):
                self?.purplemodels = product
                self?.tableView.reloadData()
            case .failure(let error):
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                self?.present(alert, animated: true)
            }
        }
    }
}
