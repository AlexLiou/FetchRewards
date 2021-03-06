//
//  DetailViewController.swift
//  FetchRewards
//
//  Created by Alex Liou on 6/26/22.
//

import UIKit
import Kingfisher

extension DetailViewController {
    class ViewModel {
        let urlString = "https://www.themealdb.com/api/json/v1/1/lookup.php?i="

        var mealDetails = [MealDetail]()

        lazy var titleLabel: UILabel = {
            let label = UILabel()
            label.text = mealDetails[0].unwrStrMeal
            label.font = .boldSystemFont(ofSize: 30)
            label.numberOfLines = 0
            label.sizeToFit()
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()

        lazy var topImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.kf.setImage(with: URL(string: mealDetails[0].unwrStrMealThumb)) { result in
                switch result {
                case .success(let value):
                    print("Image: \(value.image). Got from: \(value.cacheType)")
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.sizeToFit()
            imageView.layer.masksToBounds = true
            imageView.layer.borderWidth = 1.5
            imageView.layer.borderColor = UIColor.black.cgColor
            return imageView
        }()

        lazy var listView: UIView = {
            return generateList()
        }()

        func parse(json: Data) {
            let decoder = JSONDecoder()

            if let jsonPetitions = try? decoder.decode(MealDetailResponse.self, from: json) {
                mealDetails = jsonPetitions.meals
                
            }
        }

        @objc func generateList() -> UIView {
            lazy var contentView: UIView = {
                let view = UIView()
                view.translatesAutoresizingMaskIntoConstraints = false
                return view
            }()
            let dict: KeyValuePairs<String, String> = [
                mealDetails[0].unwrStrIngredient1: mealDetails[0].unwrStrMeasure1,
                mealDetails[0].unwrStrIngredient2: mealDetails[0].unwrStrMeasure2,
                mealDetails[0].unwrStrIngredient3: mealDetails[0].unwrStrMeasure3,
                mealDetails[0].unwrStrIngredient4: mealDetails[0].unwrStrMeasure4,
                mealDetails[0].unwrStrIngredient5: mealDetails[0].unwrStrMeasure5,
                mealDetails[0].unwrStrIngredient6: mealDetails[0].unwrStrMeasure6,
                mealDetails[0].unwrStrIngredient7: mealDetails[0].unwrStrMeasure7,
                mealDetails[0].unwrStrIngredient8: mealDetails[0].unwrStrMeasure8,
                mealDetails[0].unwrStrIngredient9: mealDetails[0].unwrStrMeasure9,
                mealDetails[0].unwrStrIngredient10: mealDetails[0].unwrStrMeasure10,
                mealDetails[0].unwrStrIngredient11: mealDetails[0].unwrStrMeasure11,
                mealDetails[0].unwrStrIngredient12: mealDetails[0].unwrStrMeasure12,
                mealDetails[0].unwrStrIngredient13: mealDetails[0].unwrStrMeasure13,
                mealDetails[0].unwrStrIngredient14: mealDetails[0].unwrStrMeasure14,
                mealDetails[0].unwrStrIngredient15: mealDetails[0].unwrStrMeasure15,
                mealDetails[0].unwrStrIngredient16: mealDetails[0].unwrStrMeasure16,
                mealDetails[0].unwrStrIngredient17: mealDetails[0].unwrStrMeasure17,
                mealDetails[0].unwrStrIngredient18: mealDetails[0].unwrStrMeasure18,
                mealDetails[0].unwrStrIngredient19: mealDetails[0].unwrStrMeasure19,
                mealDetails[0].unwrStrIngredient20: mealDetails[0].unwrStrMeasure20,
            ]

            var previous: UILabel?
            for (key, value) in dict {
                var text = ""
                if !value.isEmpty {
                    text.append(value + " ")
                }
                if !key.isEmpty {
                    text.append(key)
                }
                if !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    let label = UILabel()
                    label.translatesAutoresizingMaskIntoConstraints = false
                    label.sizeToFit()
                    label.text = "\u{2022} \(text)"
                    contentView.addSubview(label)
                    label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
                    label.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 3/4).isActive = true

                    if let previous = previous {
                        // we have a previous label - create a height constraint
                        label.topAnchor.constraint(equalTo: previous.bottomAnchor, constant: 10).isActive = true
                    } else {
                        label.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
                    }

                    previous = label
                }
            }
            previous?.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
            return contentView
        }

        lazy var directionsTextLabel: UILabel = {
            let label = UILabel()
            label.text = mealDetails[0].unwrStrInstructions
            label.numberOfLines = 0
            label.sizeToFit()
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()

    }
}

class DetailViewController: UIViewController {
    var id: String?
    var vm = ViewModel()
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        return view
    }()
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let ingredientsLabel: UILabel = {
        let label = UILabel()
        label.text = "Ingredients"
        label.font = .boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let directionsLabel: UILabel = {
        let label = UILabel()
        label.text = "Directions"
        label.font = .boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setupScrollView()

        if let url = URL(string: vm.urlString + id!) {
            if let data = try? Data(contentsOf: url) {
                vm.parse(json: data)
                setUpAutoLayout()
                return
            }
        }
        // Do any additional setup after loading the view.
    }

    func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true

        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }

    func setUpAutoLayout() {
        contentView.addSubview(vm.titleLabel)
        vm.titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        vm.titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        vm.titleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 3/4).isActive = true

        contentView.addSubview(vm.topImageView)
        vm.topImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        vm.topImageView.topAnchor.constraint(equalTo: vm.titleLabel.bottomAnchor, constant: 25).isActive = true
        vm.topImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 3/4).isActive = true
        let targetSize = CGSize(width: view.frame.size.width, height: 250)
        vm.topImageView.image = vm.topImageView.image?.scalePreservingAspectRatio(targetSize: targetSize)

        contentView.addSubview(ingredientsLabel)
        ingredientsLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        ingredientsLabel.topAnchor.constraint(equalTo: vm.topImageView.bottomAnchor, constant: 25).isActive = true
        ingredientsLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 3/4).isActive = true

        contentView.addSubview(vm.listView)
        vm.listView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        vm.listView.topAnchor.constraint(equalTo: ingredientsLabel.bottomAnchor, constant: 25).isActive = true
        vm.listView.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true

        contentView.addSubview(directionsLabel)
        directionsLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        directionsLabel.topAnchor.constraint(equalTo: vm.listView.bottomAnchor, constant: 25).isActive = true
        directionsLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 3/4).isActive = true

        contentView.addSubview(vm.directionsTextLabel)
        vm.directionsTextLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        vm.directionsTextLabel.topAnchor.constraint(equalTo: directionsLabel.bottomAnchor, constant: 25).isActive = true
        vm.directionsTextLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 3/4).isActive = true
        vm.directionsTextLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
}
