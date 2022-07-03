//
//  MealListTableViewDataSource.swift
//  FetchRewards
//
//  Created by Alex Liou on 7/1/22.
//

import Foundation
import UIKit
import Kingfisher

protocol MealListTableViewDelegate: AnyObject {
    func showMealDetail(_ meal: Meal)
}

class MealListTableViewDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    private weak var delegate: MealListTableViewDelegate?
    private let tableView: UITableView

    var meals: [Meal] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    init(meals: [Meal] = [], tableView: UITableView, delegate: MealListTableViewDelegate) {
        self.meals = meals
        self.tableView = tableView
        self.delegate = delegate
        super.init()
        setup()
    }

    private func setup() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MealTableViewCell.self, forCellReuseIdentifier: MealTableViewCell.identifier)
        tableView.allowsSelection = true
   }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MealTableViewCell.identifier, for: indexPath) as? MealTableViewCell else {
            return UITableViewCell(style: .default, reuseIdentifier: MealTableViewCell.identifier)
        }
        let meal = meals[indexPath.row]
        cell.setup(meal)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let meal = meals[indexPath.row]
        delegate?.showMealDetail(meal)
    }
}

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
        let url = URL(string: meal.unwrStrMealThumb)!

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
        title.text = meal.unwrStrMeal
        image.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 0, width: 70, height: 70, enableInsets: false)
        title.anchor(top: topAnchor, left: image.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 20, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: frame.size.width / 2, height: 0, enableInsets: false)
    }
}
