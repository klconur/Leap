//
//  APIService.swift
//  Leap
//
//  Created by ONUR KILIC on 13.01.2022.
//

import Foundation

class APIService :  NSObject {
    
    private let sourcesURL = URL(string: "https://okb.com.tr/data.json")!
    
    func apiToGetHomeData(completion : @escaping (Data?, Error?) -> ()){
        let configuration = URLSessionConfiguration.ephemeral
        let session = URLSession(configuration: configuration)
        session.dataTask(with: sourcesURL) { (data, urlResponse, error) in
            if let data = data {
                let jsonDecoder = JSONDecoder()
                let homeData = try! jsonDecoder.decode(Data.self, from: data)
                completion(homeData, error)
            } else {
                completion(nil, error)
            }
        }.resume()
    }
}
