//
//  MealDetailIngredientList.swift
//  FetchRewards
//
//  Created by Alex Liou on 7/4/22.
//

import UIKit

class MealDetailIngredientList: UIView {
    let mealDetails: [MealDetail]

    init(mealDetails: [MealDetail]) {
        self.mealDetails = mealDetails
        super.init(frame: .zero)
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
        self.addSubview(contentView)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
