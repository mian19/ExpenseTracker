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
        let request = URLRequest(url: url)

        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else { return }
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
