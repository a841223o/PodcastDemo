//
//  HomePageViewModel.swift
//  PodcastDemo
//
//  Created by leo on 2022/6/14.
//

import Foundation

protocol HomePageViewModelDelegate : class {
    func didLoadData()
}

class HomePageViewModel {
    var model : EpisodeOCModel?
    weak var delegate : HomePageViewModelDelegate?
    func loadUserEpisodeModel(){
        
        NetworkService().user(of: "322164009") { result in
            switch result {
            case .success(let model):
                self.model = model
                self.delegate?.didLoadData()
            case .failure(let error): break
            }
        }
        
    }
    
}
