//
//  MealListTableViewControllerViewModel.swift
//  FetchRewards
//
//  Created by Alex Liou on 7/4/22.
//

import Foundation
import UIKit

class MealListTableViewControllerViewModel {

    var meals: [Meal] = []
    var repo: MealRepoable = MealRepository.shared
    
    func loadData() async {
        do {
            let meals = try await repo.getMeals()
            self.meals = meals
        } catch let error {
            print(error)
        }
    }
}

