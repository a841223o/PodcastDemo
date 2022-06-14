//
//  ViewController.swift
//  PodcastDemo
//
//  Created by leo on 2022/6/14.
//

import UIKit

class HomePageViewController : UIViewController {
    let tableView = UITableView()
    let viewModel = HomePageViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        viewModel.loadUserEpisodeModel()
    }
    
    func setupTableView(){
        tableView.register(EpisodeCell.self, forCellReuseIdentifier: "cell")
        tableView.frame = self.view.frame
        self.view.addSubview(tableView)
        tableView.backgroundColor = .white
        let imageView = UIImageView()
        imageView.frame = CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height/3)
        imageView.backgroundColor = .blue
        tableView.tableHeaderView = imageView
        tableView.delegate = self
        tableView.dataSource = self
    }

}



extension HomePageViewController : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! EpisodeCell
    
        return cell
    }
    
    
}

