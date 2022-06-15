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
    let headImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        viewModel.delegate = self
        viewModel.loadUserEpisodeModel()
        
    }
    
    func setupTableView(){
        tableView.register(EpisodeCell.self, forCellReuseIdentifier: "cell")
        tableView.frame = self.view.frame
        self.view.addSubview(tableView)
        tableView.backgroundColor = .white
        tableView.rowHeight = 90
        headImageView.frame = CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height/3)
        headImageView.backgroundColor = .white
        headImageView.contentMode = .scaleAspectFill
        headImageView.clipsToBounds = true
        tableView.tableHeaderView = headImageView
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func presentToEspisodePage(with  index: Int ){
        guard let model = viewModel.model else{
            return
        }
        let vc = EpisodePageViewController()
        vc.viewModel = EpisodePageViewModel.init(title: viewModel.model?.title ?? "", index: index, model: model )
        self.navigationController?.pushViewController(vc, animated: true)
    }

}



extension HomePageViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presentToEspisodePage(with: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.model?.items.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! EpisodeCell
        if let item = viewModel.model?.items[indexPath.row] {
            cell.setupMode(model: item)
        }
        return cell
    }
    
    
    func loadVisibleCellsImage(){
        for cell in tableView.visibleCells {
            (cell  as! EpisodeCell).loadImage()
        }
    }
    
    
}

extension HomePageViewController : HomePageViewModelDelegate {
    func didLoadData() {
        
        if let imageUrl = URL.init(string: viewModel.model?.headImageUrl ?? "") {
            headImageView.loadImage(at: imageUrl )
        }
        tableView.reloadData()
        loadVisibleCellsImage()
    }
}

