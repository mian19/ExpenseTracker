//
//  NetworkManager.swift
//  ExpenseTracker
//
//  Created by Kyzu on 25.12.22.
//

import Foundation

class NetworkManager {
    
    func getBTC(completion: @escaping (Result<BitcoinExchange, Error>) -> Void) {
        let url = URL(string: "https://api.coindesk.com/v1/bpi/currentprice.json")!
        var request = URLRequest(url: url)
//        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")  // the request is JSON
//        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")        // the expected response is also JSON
//        request.httpMethod = "GET"
    
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else { return }
           // print(String(data: data, encoding: .utf8)!)
            do {
                let jsonAnswer = try JSONDecoder().decode(BitcoinExchange.self, from: data)
                DispatchQueue.main.async {
                    print(jsonAnswer)
                    completion(.success(jsonAnswer))
                }
            } catch{
                print(String(describing: error))
            }
        }
        task.resume()
    }
}
