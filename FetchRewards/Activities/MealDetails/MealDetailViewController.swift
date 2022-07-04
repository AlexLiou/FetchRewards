//
//  MealDetailViewController.swift
//  FetchRewards
//
//  Created by Alex Liou on 7/1/22.
//

import UIKit

extension MealDetailViewController {
    class ViewModel {
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
}

class MealDetailViewController: UIViewController {
    var id: String?
    var mealDetails: [MealDetail] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        let vm = ViewModel(id: id!)
        Task {
            await vm.loadData()
            let scrollView = MealDetailScrollView(mealDetails: vm.mealDetails)
            view.addSubview(scrollView)
            scrollView.frame = view.frame
        }
    }
}
