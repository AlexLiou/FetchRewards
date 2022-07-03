//
//  MealDetailViewController+Layout.swift
//  FetchRewards
//
//  Created by Alex Liou on 7/3/22.
//

import UIKit

extension MealDetailViewController {

    func generateList() -> UIView {
        lazy var contentView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        let dict: KeyValuePairs<String, String> = [
            mealDetails[0].strIngredient1: mealDetails[0].strMeasure1,
            mealDetails[0].strIngredient2: mealDetails[0].strMeasure2,
            mealDetails[0].strIngredient3: mealDetails[0].strMeasure3,
            mealDetails[0].strIngredient4: mealDetails[0].strMeasure4,
            mealDetails[0].strIngredient5: mealDetails[0].strMeasure5,
            mealDetails[0].strIngredient6: mealDetails[0].strMeasure6,
            mealDetails[0].strIngredient7: mealDetails[0].strMeasure7,
            mealDetails[0].strIngredient8: mealDetails[0].strMeasure8,
            mealDetails[0].strIngredient9: mealDetails[0].strMeasure9,
            mealDetails[0].strIngredient10: mealDetails[0].strMeasure10,
            mealDetails[0].strIngredient11: mealDetails[0].strMeasure11,
            mealDetails[0].strIngredient12: mealDetails[0].strMeasure12,
            mealDetails[0].strIngredient13: mealDetails[0].strMeasure13,
            mealDetails[0].strIngredient14: mealDetails[0].strMeasure14,
            mealDetails[0].strIngredient15: mealDetails[0].strMeasure15,
            mealDetails[0].strIngredient16: mealDetails[0].strMeasure16,
            mealDetails[0].strIngredient17: mealDetails[0].strMeasure17,
            mealDetails[0].strIngredient18: mealDetails[0].strMeasure18,
            mealDetails[0].strIngredient19: mealDetails[0].strMeasure19,
            mealDetails[0].strIngredient20: mealDetails[0].strMeasure20,
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
    
    func setUpViews() {
        print(mealDetails)
        view.backgroundColor = UIColor.white
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

//        scrollView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: self.view.frame.width, height: self.view.frame.height, enableInsets: false)

        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true

//        contentView.anchor(top: scrollView.topAnchor, left: scrollView.leftAnchor, bottom: scrollView.bottomAnchor, right: scrollView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: scrollView.frame.size
//            .width, height: scrollView.frame.size.height, enableInsets: false)

        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true

        contentView.addSubview(titleLabel)
        titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 3/4).isActive = true

        contentView.addSubview(topImageView)
        topImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        topImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 25).isActive = true
        topImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 3/4).isActive = true
        let targetSize = CGSize(width: view.frame.size.width, height: 250)
        topImageView.image = topImageView.image?.scalePreservingAspectRatio(targetSize: targetSize)

        contentView.addSubview(ingredientsLabel)
        ingredientsLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        ingredientsLabel.topAnchor.constraint(equalTo: topImageView.bottomAnchor, constant: 25).isActive = true
        ingredientsLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 3/4).isActive = true

        contentView.addSubview(listView)
        listView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        listView.topAnchor.constraint(equalTo: ingredientsLabel.bottomAnchor, constant: 25).isActive = true
        listView.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true

        contentView.addSubview(directionsLabel)
        directionsLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        directionsLabel.topAnchor.constraint(equalTo: listView.bottomAnchor, constant: 25).isActive = true
        directionsLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 3/4).isActive = true

        contentView.addSubview(directionsTextLabel)
        directionsTextLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        directionsTextLabel.topAnchor.constraint(equalTo: directionsLabel.bottomAnchor, constant: 25).isActive = true
        directionsTextLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 3/4).isActive = true
        directionsTextLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
}
