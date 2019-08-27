//
//  ApiManager.swift
//  BuyerGuide
//
//  Created by Peanuz on 27/8/2562 BE.
//  Copyright © 2562 SCB. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol APIManagerProtocol {
    func getPurpleModel(completion: @escaping (Swift.Result<[PurpleModel], Error>) -> Void)
}

class APIManager: APIManagerProtocol {
    let baseURL: String = "https://scb-test-mobile.herokuapp.com/api/mobiles/"
    static let shared: APIManager = APIManager()
    
    func getPurpleModel(completion: @escaping (Swift.Result<[PurpleModel], Error>) -> Void) {
        AF.request(baseURL)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    do {
                        let product = try JSONDecoder().decode([PurpleModel].self, from: response.data!)
                        completion(.success(product))
                    } catch (let error) {
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
        }
    }
    
    }
