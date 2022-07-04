//
//  MealDetailImageView.swift
//  FetchRewards
//
//  Created by Alex Liou on 7/4/22.
//

import UIKit

class MealDetailImageView: UIImageView {
    fileprivate let url: String

    init(url: String) {
        self.url = url
        super.init(frame: .zero)
        
        self.kf.setImage(with: URL(string: url)) { result in
            switch result {
            case .success(let value):
                print("Image: \(value.image). Got from: \(value.cacheType)")
            case .failure(let error):
                print("Error: \(error)")
            }
        }
        self.contentMode = .scaleAspectFit
        self.translatesAutoresizingMaskIntoConstraints = false
        self.sizeToFit()
        self.layer.masksToBounds = true
        self.layer.borderWidth = 1.5
        self.layer.borderColor = UIColor.black.cgColor
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
