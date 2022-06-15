//
//  EpisodeCell.swift
//  PodcastDemo
//
//  Created by leo on 2022/6/14.
//

import Foundation
import UIKit


class EpisodeCell : UITableViewCell {
    
    let pictureView : UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
        }()
    let nameLabel : UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "name"
        return view
        }()
    let dateLabel : UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "date"
        return view
        }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(pictureView)
        addSubview(nameLabel)
        addSubview(dateLabel)
    
        pictureView.topAnchor.constraint(equalTo: topAnchor ,constant: 8).isActive = true
        pictureView.bottomAnchor.constraint(equalTo: bottomAnchor , constant: -8).isActive = true
        pictureView.leftAnchor.constraint(equalTo: leftAnchor , constant: 8).isActive = true
        pictureView.widthAnchor.constraint(equalTo: pictureView.heightAnchor).isActive = true
        
        nameLabel.topAnchor.constraint(equalTo: pictureView.topAnchor).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: pictureView.rightAnchor,constant: 8).isActive = true
        
        dateLabel.bottomAnchor.constraint(equalTo: pictureView.bottomAnchor).isActive = true
        dateLabel.leftAnchor.constraint(equalTo: pictureView.rightAnchor,constant: 8).isActive = true
        
    }
    
    var model : EpisodeOCItem?
    
    func setupMode(model : EpisodeOCItem){
        self.model = model
        self.nameLabel.text = model.title
        self.dateLabel.text = model.date
        
    }
    func loadImage(){
        if let imageStr = self.model?.image , let imageUrl = URL.init(string: imageStr) {
            self.pictureView.loadImage(at: imageUrl)
        }
    }
    override func prepareForReuse() {
        self.pictureView.cancelImageLoad()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
