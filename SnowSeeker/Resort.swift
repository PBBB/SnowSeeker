//
//  Resort.swift
//  SnowSeeker
//
//  Created by Issac Penn on 2019/12/30.
//  Copyright © 2019 Issac Penn. All rights reserved.
//
import Foundation
struct Resort: Codable, Identifiable {
    let id: String
    let name: String
    let country: String
    let description: String
    let imageCredit: String
    let price: Int
    let size: Int
    let snowDepth: Int
    let elevation: Int
    let runs: Int
    let facilities: [String]
    
    var facilityTypes: [Facility] {
        facilities.map(Facility.init)
    }
    
    static let allResorts: [Resort] = Bundle.main.decode("resorts.json")
    static let example = allResorts[0]
}

extension Resort {
    var sizeString: String {
        switch self.size {
        case 1:
            return "Small"
        case 2:
            return "Average"
        default:
            return "Large"
        }
    }
    
    var priceString: String {
        String(repeating: "$", count: self.price)
    }
}
