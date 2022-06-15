//
//  EpisodePageViewModel.swift
//  PodcastDemo
//
//  Created by leo on 2022/6/15.
//

import Foundation



class EpisodePageViewModel {
    let title : String
    let index : Int
    let model : EpisodeOCModel
    
    var currentItem : EpisodeOCItem  {
        get{
            return model.items[index]
        }
    }
    
    init(title : String , index : Int,  model : EpisodeOCModel){
        self.index = index
        self.title = title
        self.model = model
    }
    
    
    
}
