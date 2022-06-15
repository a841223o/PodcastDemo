//
//  PlayerPageViewModel.swift
//  PodcastDemo
//
//  Created by leo on 2022/6/15.
//

import Foundation
import AVFoundation

protocol PlayerPageViewModelDelegate : class {
    func playerStatusChange()
}

class PlayerPageViewModel {
    
    private var index : Int
    private let model : EpisodeOCModel
    private var player : AVPlayer
    private var playItem : AVPlayerItem
    var delegate : PlayerPageViewModelDelegate?
    
    var currentItem : EpisodeOCItem  {
        get{
            return model.items[index]
        }
    }
    
    var isPlaying : Bool {
        get {
            player.rate != 0
        }
    }
    
    init(index : Int,  model : EpisodeOCModel){
        
        self.index = index
        self.model = model
        playItem = AVPlayerItem.init(url: URL.init(string: "https://feeds.soundcloud.com/stream/1049730745-daodutech-unconsciously-walking-in-starbucks.mp3")!)
        player = AVPlayer.init(playerItem: playItem)
        player.play()
        player.addPeriodicTimeObserver(forInterval: CMTimeMake(value: 1, timescale: 1), queue: DispatchQueue.main, using: { time in
            let currentTime = CMTimeGetSeconds(self.player.currentTime())
           // self.timeLine.value = Float(currentTime)
        })
    }
    
    func getDuration(complete : ((Float64)->())? ){
        DispatchQueue.global().async {
            let duration = self.playItem.asset.duration
            let sec = CMTimeGetSeconds(duration)
            DispatchQueue.main.async {
                complete?(sec)
            }
        }
    }
    
    func playerSeekTo(_ target : Int){
        let sec = Int64(target)
        let targetTime = CMTimeMake(value: sec, timescale: 1)
        player.seek(to: targetTime)
    }
    
    
    func play(){
        player.play()
        delegate?.playerStatusChange()
    }
    
    func pause(){
        player.pause()
        delegate?.playerStatusChange()
    }
    
    
}
