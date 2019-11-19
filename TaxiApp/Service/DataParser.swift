//
//  DataParser.swift
//  TaxiApp
//
//  Created by Dipak V. Vyawahare on 18/11/19.
//  Copyright © 2019 MyOrganization. All rights reserved.
//

import UIKit

protocol DataParser {
    func parse<T: Decodable>(data: Data?) -> Result<T, ErrorResult>
}

extension DataParser {
    func parse<T: Decodable>(data: Data?) -> Result<T, ErrorResult> {
        do {
            let decoder = JSONDecoder()
            if let data = data {
                let model = try decoder.decode(T.self,
                                               from: data)
                return .success(model)
            } else {
                return .failure(ErrorResult(.parser, "No Json data"))
            }
            
        } catch _ {
            return .failure(ErrorResult(.parser, "Error while parsing json data"))
        }
    }
}
