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
            
            guard response.statusCode == 200 else{
                complete(.failure(.unexpect))
                return
            }
            
            guard let data = data else {
                complete(.failure(.unexpect))
                return
            }
            
            EpisodeParser.init(data: data) { model in
                if let model = model {
                    DispatchQueue.main.async {
                        complete(.success(model))
                    }
                }
            }
            
        }.resume()
    }
    
}
