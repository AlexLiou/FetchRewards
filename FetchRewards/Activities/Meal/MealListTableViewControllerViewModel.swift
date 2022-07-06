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
        repo.getMeals { result in
            switch result {
            case .success(let meals):
                self.meals = meals
                print(self.meals.count)
            case .failure(let error):
                print(error)
            }
        }
    }
}

