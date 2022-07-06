//
//  MealDetailViewControllerViewModel.swift
//  FetchRewards
//
//  Created by Alex Liou on 7/4/22.
//

import Foundation

class MealDetailViewControllerViewModel {
    let urlString = "https://www.themealdb.com/api/json/v1/1/lookup.php?i="
    var id: String?
    var mealDetails: [MealDetail] = []
    init(id: String) {
        self.id = id
    }

    func loadData() async {
        guard let url = URL(string: urlString + id!) else {
            print("Invalid URL")
            return
        }
        print(url)

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode(MealDetailResponse.self, from: data) {
                let meals = decodedResponse.meals
                mealDetails = meals
            }
        } catch {
            print("Invalid data")
        }
    }
}
