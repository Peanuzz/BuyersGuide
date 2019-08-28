//
//  FullListViewController.swift
//  BuyerGuide
//
//  Created by Peanuz on 27/8/2562 BE.
//  Copyright © 2562 SCB. All rights reserved.
//

import UIKit
import Alamofire

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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            let vc = segue.destination as? DetailsViewController
            let indexPath = tableView.indexPathForSelectedRow
            if let indexPath = indexPath {
                vc?.purple = purplemodels[(indexPath as NSIndexPath).row]
                let item: PurpleModel = purplemodels[indexPath.item]
                let id = item.id
                print(id)
                vc?.mobileID = id
            }
        }
    }
    
    @IBAction func actionSort(_ sender: Any) {
        let alert = UIAlertController(title: "Sort",
                                      message: "",
                                      preferredStyle: .alert)
        let sortLowtoHight = UIAlertAction(title: "Sort Low to Hight", style: .default,handler: { (action) -> Void in
            self.purplemodels = self.purplemodels.sorted(by: { $0.price < $1.price })
            self.tableView.reloadData()
        })
        let sortHighttoLow = UIAlertAction(title: "Sort Hight to Low", style: .default,handler: { (action) -> Void in
            self.purplemodels = self.purplemodels.sorted(by: { $0.price > $1.price })
            self.tableView.reloadData()
        })
        let sortRating = UIAlertAction(title: "Rating", style: .default,handler: { (action) -> Void in
            self.purplemodels = self.purplemodels.sorted(by: { $0.rating > $1.rating })
            self.tableView.reloadData()
        })
        
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: { (action) -> Void in })
        
        alert.addAction(sortLowtoHight)
        alert.addAction(sortHighttoLow)
        alert.addAction(sortRating)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
        
    }
}

extension FullListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.purplemodels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PurpleTableViewCell.CellIdentifier, for: indexPath) as? PurpleTableViewCell else {
            return UITableViewCell()
        }
        let purple: PurpleModel = purplemodels[indexPath.item]
        cell.configCell(purple: purple)
        return cell
    }
}

extension FullListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
