//
//  URLExtensions.swift
//  TaxiApp
//
//  Created by Dipak V. Vyawahare on 19/11/19.
//  Copyright © 2019 MyOrganization. All rights reserved.
//

import Foundation

extension URL {
    func appendParameters(params: [String: String]) -> URL {
        var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: true)!
        var items = urlComponents.queryItems ?? []
        items += params.map({ URLQueryItem(name: $0, value: $1) })
        urlComponents.queryItems = items
        return urlComponents.url!
    }
}
