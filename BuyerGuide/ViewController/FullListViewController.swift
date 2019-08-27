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
        
        tableView.estimatedRowHeight = 500
        tableView.rowHeight = UITableView.automaticDimension
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            let vc = segue.destination as? DetailsViewController
            let indexPath = tableView.indexPathForSelectedRow
            if let indexPath = indexPath {
                vc?.purple = purplemodels[(indexPath as NSIndexPath).row]
            }
        }
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
        let item = self.purplemodels[indexPath.row]
        cell.nameLabel.text = item.name
        cell.descriptionLabel.text = item.description
        cell.priceLabel.text = "\(item.price)"
        cell.ratingLabel.text = "\(item.rating)"
        cell.productImageView.kf.setImage(with: URL(string: item.thumbImageURL))
//        let purple: PurpleModel = purplemodels[indexPath.item]
//        cell.configCell(purple: purple)
        return cell
    }
}

//extension FullListViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
//}
