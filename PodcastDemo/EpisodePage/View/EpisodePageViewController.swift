//
//  EpisodePageViewController.swift
//  PodcastDemo
//
//  Created by leo on 2022/6/15.
//

import Foundation
import UIKit



class EpisodePageViewController : UIViewController {
    
    let scrollerView = UIScrollView()
    let imageView  = UIImageView()
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    let summaryLabel  = UILabel()
    let playButton = UIButton()
    var viewModel : EpisodePageViewModel?
    
    override func viewDidLoad() {
        self.view.backgroundColor = .white
        setupScrollerView()
        setupImageView()
        setupTitle()
        setupsubTitle()
        setupSummary()
        setupPlayButton()
        updateScrollerView()
    }
    
    func setupScrollerView(){
        self.scrollerView.frame = self.view.frame
        self.scrollerView.contentSize = CGSize.init(width: self.view.frame.width, height: self.view.frame.height*2)
        self.view.addSubview(scrollerView)
    }
    
    func setupImageView(){
        self.scrollerView.addSubview(imageView)
        imageView.backgroundColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: self.scrollerView.topAnchor, constant: 0).isActive = true
        imageView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 8).isActive = true
        imageView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -8).isActive = true
        imageView.heightAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        
        if let imageStr = viewModel?.currentItem.image , let imageURl = URL.init(string: imageStr) {
            imageView.loadImage(at: imageURl)
        }
    }
    
    func setupTitle(){
        self.scrollerView.addSubview(titleLabel)
        titleLabel.text = viewModel?.title
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 64).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: imageView.leftAnchor, constant: 32).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: imageView.rightAnchor, constant: -32).isActive = true
    }
    
    func setupsubTitle(){
        self.scrollerView.addSubview(subtitleLabel)
        subtitleLabel.text = viewModel?.currentItem.title
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 64).isActive = true
        subtitleLabel.leftAnchor.constraint(equalTo: imageView.leftAnchor, constant: 32).isActive = true
        subtitleLabel.rightAnchor.constraint(equalTo: imageView.rightAnchor, constant: -32).isActive = true
    }
    
    func setupSummary(){
        self.scrollerView.addSubview(summaryLabel)
        summaryLabel.numberOfLines = 100
        summaryLabel.text = viewModel?.currentItem.summary
        summaryLabel.translatesAutoresizingMaskIntoConstraints = false
        summaryLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16).isActive = true
        summaryLabel.leftAnchor.constraint(equalTo: imageView.leftAnchor, constant: 0).isActive = true
        summaryLabel.rightAnchor.constraint(equalTo: imageView.rightAnchor, constant: 0).isActive = true
    }
    
    func setupPlayButton(){
        self.view.addSubview(playButton)
        playButton.translatesAutoresizingMaskIntoConstraints = false
        playButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 8).isActive = true
        playButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -8).isActive = true
        playButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -32).isActive = true
        playButton.heightAnchor.constraint(equalToConstant: 64).isActive = true
        playButton.setTitle("???????????? ", for: .normal)
        playButton.configuration = .filled()
        playButton.addTarget(self, action: #selector(presentToPlayerPage), for: .touchUpInside)
    }
    
    func updateScrollerView(){
        self.imageView.layoutIfNeeded()
        self.summaryLabel.layoutIfNeeded()
        self.scrollerView.contentSize = CGSize.init(width: self.view.frame.width, height: self.imageView.frame.height + self.summaryLabel.frame.height + 100)
    }
    
    @objc func presentToPlayerPage(){
        let vc = PlayerPageViewController()
        vc.viewModel = PlayerPageViewModel.init(index: viewModel!.index, model: viewModel!.model)
        self.present(vc, animated: true, completion: nil)
    }
}

