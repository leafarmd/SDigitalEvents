//
//  UIImageViewExtensions.swift
//  Test-iOS
//
//  Created by Rafael Damasceno on 28/07/19.
//  Copyright © 2019 Rafael Damasceno. All rights reserved.
//

import UIKit

extension UIImageView {
    func loadImageFromURL(_ url: String ) {
        
        APICore.loadImage(from: url) { [weak self] result in
            switch result {
            case .success(let image): self?.image = image
            case .failure(_): self?.image = UIImage(named: "noimage")
            }
        }
    }
}
