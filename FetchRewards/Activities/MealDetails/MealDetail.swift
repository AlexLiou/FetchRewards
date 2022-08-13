//
//  MealDetail.swift
//  FetchRewards
//
//  Created by Alex Liou on 6/26/22.
//

import Foundation

struct MealDetailResponse: Codable {
    var meals: [MealDetail]
}

struct MealDetail: Codable {
    @DefaultBy.Empty var idMeal: String
    @DefaultBy.Empty var strMeal: String
    @DefaultBy.Empty var strInstructions: String
    @DefaultBy.Empty var strMealThumb: String
    @DefaultBy.Empty var strIngredient1: String
    @DefaultBy.Empty var strIngredient2: String
    @DefaultBy.Empty var strIngredient3: String
    @DefaultBy.Empty var strIngredient4: String
    @DefaultBy.Empty var strIngredient5: String
    @DefaultBy.Empty var strIngredient6: String
    @DefaultBy.Empty var strIngredient7: String
    @DefaultBy.Empty var strIngredient8: String
    @DefaultBy.Empty var strIngredient9: String
    @DefaultBy.Empty var strIngredient10: String
    @DefaultBy.Empty var strIngredient11: String
    @DefaultBy.Empty var strIngredient12: String
    @DefaultBy.Empty var strIngredient13: String
    @DefaultBy.Empty var strIngredient14: String
    @DefaultBy.Empty var strIngredient15: String
    @DefaultBy.Empty var strIngredient16: String
    @DefaultBy.Empty var strIngredient17: String
    @DefaultBy.Empty var strIngredient18: String
    @DefaultBy.Empty var strIngredient19: String
    @DefaultBy.Empty var strIngredient20: String
    @DefaultBy.Empty var strMeasure1: String
    @DefaultBy.Empty var strMeasure2: String
    @DefaultBy.Empty var strMeasure3: String
    @DefaultBy.Empty var strMeasure4: String
    @DefaultBy.Empty var strMeasure5: String
    @DefaultBy.Empty var strMeasure6: String
    @DefaultBy.Empty var strMeasure7: String
    @DefaultBy.Empty var strMeasure8: String
    @DefaultBy.Empty var strMeasure9: String
    @DefaultBy.Empty var strMeasure10: String
    @DefaultBy.Empty var strMeasure11: String
    @DefaultBy.Empty var strMeasure12: String
    @DefaultBy.Empty var strMeasure13: String
    @DefaultBy.Empty var strMeasure14: String
    @DefaultBy.Empty var strMeasure15: String
    @DefaultBy.Empty var strMeasure16: String
    @DefaultBy.Empty var strMeasure17: String
    @DefaultBy.Empty var strMeasure18: String
    @DefaultBy.Empty var strMeasure19: String
    @DefaultBy.Empty var strMeasure20: String
}
