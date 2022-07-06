//
//  MealListTableViewCell.swift
//  FetchRewards
//
//  Created by Alex Liou on 7/6/22.
//
import Foundation
import UIKit
import Kingfisher

class MealTableViewCell: UITableViewCell {
    static var identifier = "cell"

    lazy var image: UIImageView = { [weak self] in
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        return imageView
    }()

    lazy var title: UILabel = { [weak self] in
        let textView = UILabel()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .left
        textView.font = UIFont.boldSystemFont(ofSize: 16)
        return textView
    }()

    func setup(_ meal: Meal) {
        addSubview(image)
        addSubview(title)
        let url = URL(string: meal.strMealThumb)

        image.kf.setImage(
            with: url,
            placeholder: UIImage(systemName: "photo"),
            options: [
                .transition(.fade(1)),
                .cacheOriginalImage
            ]
        ) { result in
            switch result {
            case .success(_):
                print("image loaded")
            case .failure(let error):
                print("Error: \(error)")
            }
        }
        title.text = meal.strMeal
        image.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 0, width: 70, height: 70, enableInsets: false)
        title.anchor(top: topAnchor, left: image.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 20, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: frame.size.width / 2, height: 0, enableInsets: false)
    }
}

