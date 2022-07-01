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
    var strMeal: String?
    var unwrStrMeal: String {
        strMeal ?? ""
    }

    var strMealThumb: String?
    var unwrStrMealThumb: String {
        strMealThumb ?? ""
    }

    var idMeal: String?
    var unwrIdMeal: String {
        idMeal ?? ""
    }
}
