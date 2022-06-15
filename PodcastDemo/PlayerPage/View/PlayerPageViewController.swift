//
//  PlayerViewPageViewController.swift
//  PodcastDemo
//
//  Created by leo on 2022/6/15.
//

import Foundation
import AVFoundation
import UIKit


class PlayerPageViewController : UIViewController {
    
    let imageView = UIImageView()
    let episodeNameLabel = UILabel()
    let nextBtn = UIButton()
    let playBtn = UIButton()
    let preBtn = UIButton()
    let timeLine = UISlider()
    let stack = UIStackView()
    var viewModel : PlayerPageViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupImageView()
        setupEpisodeNameLabel()
        setupBtns()
        setupTimeLine()
        viewModel?.getDuration(complete: { sec in
            self.timeLine.minimumValue = 0
            self.timeLine.maximumValue = Float(sec)
        })
        viewModel?.delegate = self
        //setupPlayer()
        //updateUI()
    }
    func setupTimeLine(){
        self.view.addSubview(timeLine)
        timeLine.translatesAutoresizingMaskIntoConstraints = false
        timeLine.bottomAnchor.constraint(equalTo: stack.topAnchor, constant: -16).isActive = true
        timeLine.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32).isActive = true
        timeLine.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32).isActive = true
        timeLine.addTarget(self, action: #selector(timeLineValueChange), for: .valueChanged)
    }
    
    @objc func timeLineValueChange(){
        viewModel?.playerSeekTo(Int(timeLine.value))
    }
    
    func setupBtns(){
        stack.distribution = .fillEqually
        
        self.view.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(preBtn)
        stack.addArrangedSubview(playBtn)
        stack.addArrangedSubview(nextBtn)
        stack.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16).isActive = true
        stack.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16).isActive = true
        stack.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -64).isActive = true
        stack.heightAnchor.constraint(equalToConstant: 128).isActive = true
        
        playBtn.addTarget(self, action: #selector(playBtnClick), for: .touchUpInside)
        playBtn.setBackgroundImage(UIImage.init(systemName: "play.circle"), for: .normal)
        nextBtn.setBackgroundImage(UIImage.init(systemName: "forward"), for: .normal)
        preBtn.setBackgroundImage(UIImage.init(systemName: "backward"), for: .normal)
        preBtn.imageView?.contentMode = .center
    }
    
    func setPlayBtnStatus(){
        guard let viewModel = viewModel else {
            return
        }
        if viewModel.isPlaying {
            playBtn.setBackgroundImage(UIImage.init(systemName: "pause.circle"), for: .normal)
        }else{
            playBtn.setBackgroundImage(UIImage.init(systemName: "play.circle"), for: .normal)
        }
    }
    
    @objc func playBtnClick(){
        
        guard let viewModel = viewModel else {
            return
        }
        
        if viewModel.isPlaying {
            viewModel.pause()
        }else{
            viewModel.play()
        }
        
    }
    
    func setupImageView(){
        self.view.addSubview(imageView)
        imageView.layer.cornerRadius = 8
        imageView.backgroundColor = .blue
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 8).isActive = true
        imageView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 8).isActive = true
        imageView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -8).isActive = true
        imageView.heightAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        
        if let viewModel = viewModel {
            imageView.loadImage(at: URL.init(string: viewModel.currentItem.image)!)
        }
    }
    
    func setupEpisodeNameLabel(){
        self.view.addSubview(episodeNameLabel)
        episodeNameLabel.numberOfLines = 3
        episodeNameLabel.translatesAutoresizingMaskIntoConstraints = false
        episodeNameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16).isActive = true
        episodeNameLabel.leftAnchor.constraint(equalTo: imageView.leftAnchor, constant: 0).isActive = true
        episodeNameLabel.rightAnchor.constraint(equalTo: imageView.rightAnchor, constant: 0).isActive = true
        if let viewModel = viewModel {
            episodeNameLabel.text = viewModel.currentItem.title
        }
    }
    
    
}


extension PlayerPageViewController : PlayerPageViewModelDelegate {
    func playerStatusChange() {
        setPlayBtnStatus()
    }
    
}
