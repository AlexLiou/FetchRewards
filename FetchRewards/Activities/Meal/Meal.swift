//
//  Meal.swift
//  FetchRewards
//
//  Created by Alex Liou on 6/26/22.
//

import Foundation

struct MealResponse: Codable {
    var meals: [Meal]
}

struct Meal: Codable {
    @DefaultBy.Empty var strMeal: String
    @DefaultBy.Empty var strMealThumb: String
    @DefaultBy.Empty var idMeal: String
    var empty: String
//    var strMeal: String
//    var strMealThumb: String
//    var idMeal: String
}
