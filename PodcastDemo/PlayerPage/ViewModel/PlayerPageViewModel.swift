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
    func playerTimeChange(value:Float)
    func didChangePlayItem(at index: Int)
}

class PlayerPageViewModel : NSObject {
    
    private var index : Int
    private let model : EpisodeOCModel
    private var player : AVPlayer!
    private var playItem : AVPlayerItem!
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
        super.init()
       
        NotificationCenter.default.addObserver(self, selector: #selector(audioPlayCompletion), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
        playItem = AVPlayerItem.init(url: URL.init(string: model.items[index].url!)!)
        player = AVPlayer.init(playerItem: playItem)
        
        player.addPeriodicTimeObserver(forInterval: CMTimeMake(value: 1, timescale: 1), queue: DispatchQueue.main, using: { time in
            let currentTime = CMTimeGetSeconds(self.player.currentTime())
            self.delegate?.playerTimeChange(value: Float(currentTime))
        })
        
    }
    @objc func audioPlayCompletion(){
        guard index + 1 < model.items?.count ?? 0 else{
            pause()
            return
        }
        next()
    }
    func preparePlayer(){
        setupObserver()
    }
    
    private func setupObserver(){
        playItem.addObserver(self, forKeyPath: "status", options: .new, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "status" {
            let status: AVPlayerItem.Status
                if let statusNumber = change?[.newKey] as? NSNumber {
                    status = AVPlayerItem.Status(rawValue: statusNumber.intValue)!
                } else {
                    status = .unknown
                }

                // Switch over status value
                switch status {
                case .readyToPlay:
                    print("ready")
                    play()
                case .failed:
                    ()
                case .unknown:
                    ()
                }
        }
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
    
    func next(){
        guard index-1 >= 0 else {
            return
        }
        index -= 1
        if let model = model.items?[index] , let url = URL.init(string: model.url!) {
            print(model.title)
            changePlayItem(url: url)
        }
    }
    
    func pervious(){
        guard index+1 < model.items?.count ?? 0 else {
            return
        }
        index += 1
        if let model = model.items?[index] , let url = URL.init(string: model.url!) {
            print(model.title)
            changePlayItem(url: url)
        }
    }
    
    func changePlayItem(url : URL){
        pause()
        playItem.removeObserver(self, forKeyPath: "status")
        let newPlayItem = AVPlayerItem.init(url: url)
        player.replaceCurrentItem(with: newPlayItem)
        self.playItem = newPlayItem
        setupObserver()
        delegate?.didChangePlayItem(at: index)
    }
    
    func destroyPlayer() {
        self.player.pause()
        self.player.currentItem?.cancelPendingSeeks()
        self.player.currentItem?.asset.cancelLoading()
        self.player.replaceCurrentItem(with: nil)
    }
}
