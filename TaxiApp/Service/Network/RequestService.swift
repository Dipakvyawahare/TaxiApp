//
//  RequestService.swift
//  TaxiApp
//
//  Created by Dipak V. Vyawahare on 19/11/19.
//  Copyright © 2019 MyOrganization. All rights reserved.
//

import Foundation

let endPoint = URL(string: "https://fake-poi-api.mytaxi.com")!

protocol RequestServiceProtocol {
    @discardableResult func fetchData(using params: [String: String],
                                      completion: @escaping (
        (Result<Data, ErrorResult>) -> Void)) -> URLSessionDataTask?
}

final class RequestService: RequestServiceProtocol {
    static let shared = RequestService()
    
    lazy var session: URLSession = {
        let session = URLSession(configuration: URLSessionConfiguration.default,
                                 delegate: nil,
                                 delegateQueue: OperationQueue.main)
        return session
    }()
    
    @discardableResult func fetchData(using params: [String: String],
                                      completion: @escaping (
        (Result<Data, ErrorResult>) -> Void)) -> URLSessionDataTask? {
        let apiUrl = endPoint.appendParameters(params: params)
        let request = URLRequest(url: apiUrl)
        if let reachability = Reachability(), !reachability.isReachable {
            completion(.failure(ErrorResult(.network, "No Netwok connection!")))
            return nil
        }
        let task = session.dataTask(with: request) { (data, _, error) in
            if let error = error {
                switch error {
                case _ where (error as NSError).code == NSURLErrorCancelled:
                    break
                default:
                    let msg =  "An error occured during request :" + error.localizedDescription
                    completion(.failure(ErrorResult(.parser, msg)))
                }
                return
            }
            
            if let data = data {
                completion(.success(data))
            }
        }
        task.resume()
        return task
    }
}
