//
//  ImageListViewController.swift
//  CraftDigitalCaseStudy
//
//  Created by CDGTaxi on 30/7/21.
//

import UIKit

class ImageListViewController: UIViewController {
    
    @IBOutlet weak var imageListTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var imageListSearchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        imageListTableView.separatorStyle = .none
    }

}

extension ImageListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "imageCellIdentifier", for: indexPath) as? ImageListTableViewCell else { fatalError() }
        cell.myImageView.image = #imageLiteral(resourceName: "placeholder")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
    
}

extension ImageListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        // request search image API here
    }
}

class ImageListTableViewCell: UITableViewCell {
    @IBOutlet weak var myImageView: UIImageView!
}
