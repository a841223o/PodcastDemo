//
//  NetworkingService.swift
//  PodcastDemo
//
//  Created by leo on 2022/6/14.
//

import Foundation


class NetworkService {
    
    func user(of soundId : String ,_ complete: @escaping (Result<EpisodeOCModel, APIError>) -> Void){
        guard let url = URL.init(string: "https://feeds.soundcloud.com/users/soundcloud:users:\(322164009)/sounds.rss") else{
            complete(.failure(.unexpect))
            return
        }
        
        URLSession.shared.dataTask(with:url) { data, response, error in
            
            if let error = error {
                complete(.failure(.apiError(error)))
            }
            
            guard let response = response as? HTTPURLResponse else {
                complete(.failure(.unexpect))
                return
            }
            
            if response.statusCode == 200 ,let data = data{
                let string = String(data: data, encoding: .utf8)
                
                    print(string)
                
                
                //complete(.success(EpisodeOCModel()))
                
            }

        }.resume()
        complete(.failure(.unexpect))
    }
    
}
