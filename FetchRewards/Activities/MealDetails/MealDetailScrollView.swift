//
//  MealDetailScrollView.swift
//  FetchRewards
//
//  Created by Alex Liou on 7/4/22.
//

import UIKit

class MealDetailScrollView: UIScrollView {

    let mealDetails: [MealDetail]

    lazy var contentView: UIView = { [weak self] in
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

//    lazy var titleLabel: UILabel = { [weak self] in
//        return MealDetailTitleLabel(title: mealDetails[0].strMeal)
//    }()

    lazy var topImageView: UIImageView = { [weak self] in
        return MealDetailImageView(url: mealDetails[0].strMealThumb)
    }()

    lazy var ingredientsLabel: UILabel = { [weak self] in
        return MealDetailIngredientsLabel()
    }()

    lazy var listView: UIView = { [weak self] in
        return MealDetailIngredientList(mealDetails: mealDetails)
    }()

    lazy var directionsLabel: UILabel = { [weak self] in
        return MealDetailDirectionsLabel()
    }()

    lazy var directionsTextLabel: UILabel = { [weak self] in
        return MealDetailsDirectionsTextLabel(directions: mealDetails[0].strInstructions)
    }()
    

    init(mealDetails: [MealDetail]) {
        let titleLabel = MealDetailTitleLabel(title: mealDetails[0].strMeal)

        self.mealDetails = mealDetails
        super.init(frame: .zero)

        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor.white

        setUpViews(titleLabel: titleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
