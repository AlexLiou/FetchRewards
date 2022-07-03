//
//  MealListTableViewController.swift
//  FetchRewards
//
//  Created by Alex Liou on 7/1/22.
//

import UIKit

protocol MealListView: AnyObject {
    func show(_ meals: [Meal])
}

extension MealListTableViewController {
    @MainActor
    class ViewModel {
        let urlString = "https://www.themealdb.com/api/json/v1/1/filter.php?c=Dessert"
        weak var view: MealListView?

        init(view: MealListView?) {
            self.view = view
        }

        func loadData() async {
            guard let url = URL(string: urlString) else {
                print("Invalid URL")
                return
            }

            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                if let decodedResponse = try? JSONDecoder().decode(MealResponse.self, from: data) {
                    let meals = decodedResponse.meals
                    self.view?.show(meals)
                }
            } catch {
                print("Invalid data")
            }
        }
    }
}

class MealListTableViewController: UIViewController, MealListView {
    lazy var tableView: UITableView = { [weak self] in
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    var tableViewDataSource: MealListTableViewDataSource?

    override func viewDidLoad() {
        super.viewDidLoad()
        let vm = ViewModel(view: self)

        setUpViews()
        Task {
            await vm.loadData()
            tableView.reloadData()
        }
    }
    
    func show(_ meals: [Meal]) {
        tableViewDataSource?.meals = meals
    }
}

extension MealListTableViewController: MealListTableViewDelegate {

    func showMealDetail(_ meal: Meal) {
        let vc = MealDetailViewController()
        vc.id = meal.unwrIdMeal
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
