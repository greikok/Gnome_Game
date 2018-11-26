//
//  DataService.swift
//  BrastlewarkGame
//
//  Created by Hector Hernandez on 11/22/18.
//  Copyright © 2018 Hector Hernandez. All rights reserved.
//


import Foundation
import Alamofire


class DataService {
    
    let apiUrl: String!

    init() {
        self.apiUrl = "https://raw.githubusercontent.com/rrafols/mobile_test/master/data.json"
    }

    func getData(completionHandler: @escaping (NSDictionary?, Error?) -> ()) {
        var originalRequest = try! URLRequest(url: self.apiUrl, method: .get)
        originalRequest.cachePolicy = .reloadIgnoringLocalCacheData

        Alamofire.request(originalRequest)
            .responseJSON { response in
                switch response.result {
                    case .success(let value):
                        completionHandler(value as? NSDictionary, nil)
                    case .failure(let error):
                        completionHandler(nil, error)
                }
        }
    }
}
