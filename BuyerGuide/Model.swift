//
//  Model.swift
//  BuyerGuide
//
//  Created by Peanuz on 27/8/2562 BE.
//  Copyright © 2562 SCB. All rights reserved.
//

import Foundation

typealias Model = [PurpleModel]

struct PurpleModel: Codable {
    let rating: Double
    let id: Int
    let thumbImageURL: String
    let price: Double
    let brand, name, description: String
}

typealias TopLevel = [PurpleTopLevel]

struct PurpleTopLevel: Codable {
    let url: String
    let id, mobileID: Int

    enum CodingKeys: String, CodingKey {
        case url, id
        case mobileID = "mobile_id"
    }
}




