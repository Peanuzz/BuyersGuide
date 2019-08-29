//
//  DetailsViewController.swift
//  BuyerGuide
//
//  Created by Peanuz on 27/8/2562 BE.
//  Copyright © 2562 SCB. All rights reserved.
//

import UIKit
import Kingfisher

class DetailsViewController: UIViewController {
    
    var purpletop: [PurpleTopLevel] = []
    var purple: PurpleModel?
    var mobileID:Int?
    @IBOutlet weak var mCollectionView:UICollectionView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        getPurpleTop(mobileID!)
    }
    
    func setupUI() {
        title = purple?.name
        descriptionLabel.text = purple?.description
        priceLabel.text = "Price: $\(purple!.price)"
        rateLabel.text = "Rating: \(purple!.rating)"
    }
    
    func getPurpleTop(_ mobileID:Int) {
        APIManager.shared.getPurpleTop(mobileID: mobileID) { [weak self] result in
            switch result {
            case .success(let product):
                self?.purpletop = product
                self?.mCollectionView.reloadData()
            case .failure(let error):
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                self?.present(alert, animated: true)
            }
        }
    }
}

extension DetailsViewController:UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.purpletop.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImageCollectionViewCell
        let item = purpletop[indexPath.row]
        let url = item.url
        if url.contains("http"){
            cell.mImage.kf.setImage(with: URL(string: url))
        } else {
            cell.mImage.kf.setImage(with: URL(string: "http://\(url)"))
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.size
        return CGSize(width: size.width, height: size.height)
    }
   
}
