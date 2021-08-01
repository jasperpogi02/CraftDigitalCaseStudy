//
//  ImageDetailViewController.swift
//  CraftDigitalCaseStudy
//
//  Created by CDGTaxi on 1/8/21.
//

import Foundation
import UIKit
import Kingfisher

class ImageDetailViewController: UIViewController {
    
    @IBOutlet weak var imageDetailView: UIImageView!
    
    lazy var viewModel: ImageDetailViewModel = {
        return ImageDetailViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let imageUrl = self.viewModel.imageDetail?.url {
            self.imageDetailView.kf.setImage(with: URL(string: imageUrl)) { result in
                switch result {
                case .success:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                    self.navigationController?.popViewController(animated: false)
                }
                
            }
        }
    }
    
}
