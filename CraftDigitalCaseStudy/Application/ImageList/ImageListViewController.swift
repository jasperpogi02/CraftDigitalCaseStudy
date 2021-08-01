//
//  ImageListViewController.swift
//  CraftDigitalCaseStudy
//
//  Created by CDGTaxi on 30/7/21.
//

import UIKit
import Kingfisher

class ImageListViewController: UIViewController {
    
    @IBOutlet weak var imageListTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var imageListSearchBar: UISearchBar!
    
    lazy var viewModel: ImageListViewModel = {
        return ImageListViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        imageListTableView.separatorStyle = .none
        activityIndicator.stopAnimating()
    }
    
    fileprivate func fetchImages() {
        self.activityIndicator.startAnimating()
        viewModel.fetchImages { [weak self] in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
                self?.viewModel.isLoading = false
                self?.imageListTableView.reloadData()
            }
        }
    }
    
}

extension ImageListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.images?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "imageCellIdentifier",
                                                       for: indexPath) as? ImageListTableViewCell else { fatalError() }
        if viewModel.images?.isEmpty == false {
            cell.cellDetails = viewModel.images?[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let imageDetailVC = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(identifier: "ImageDetailViewController") as? ImageDetailViewController {
            imageDetailVC.viewModel.imageDetail = viewModel.images?[indexPath.row]
            self.navigationController?.pushViewController(imageDetailVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
    
}

extension ImageListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        if let keyword = searchBar.text {
            guard keyword.isEmpty == false else { return }
            viewModel.imageRequestData.q = keyword
            fetchImages()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            viewModel.imageRequestData = ImageRequest()
        }
    }
}

extension ImageListViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let hasReachedEnd = scrollView.contentOffset.y >= 0
            && scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)
        if hasReachedEnd {
            guard viewModel.isLoading == false else { return }
            viewModel.imageRequestData.pageSize += 10
            fetchImages()
        }
    }
}

class ImageListTableViewCell: UITableViewCell {
    @IBOutlet weak var myImageView: UIImageView!
    
    var cellDetails: Images? {
        didSet {
            if let thumbnailUrl = cellDetails?.thumbnail {
                myImageView.kf.setImage(with: URL(string: thumbnailUrl))
            }
        }
    }
}
