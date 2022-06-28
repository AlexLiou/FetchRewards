//
//  ViewController.swift
//  FetchRewards
//
//  Created by Alex Liou on 6/26/22.
//

import UIKit
import Kingfisher
// Learn how to deal with async await

extension ViewController {
    @MainActor
    class ViewModel {
        let urlString = "https://www.themealdb.com/api/json/v1/1/filter.php?c=Dessert"
        var meals: [Meal] = []
        var showingLoading: Bool = false
        var showingError: Bool = false

        var repo: MealRepoable = MealRepository.shared

        lazy var tableView: UITableView = {
            let tableView = UITableView()
            return tableView
        }()

//        func getMeals() {
//            showingLoading = true
//            repo.getMeals { result in
//                self.showingLoading = false
//                switch result {
//                case .success(let meals):
//                    self.meals = meals
//                    self.showingError = false
//                case .failure(let error):
//                    self.showingError = true
//                    print(error)
//                }
//            }
//        }
        func loadData() async {
            guard let url = URL(string: urlString) else {
                print("Invalid URL")
                return
            }

            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                if let decodedResponse = try? JSONDecoder().decode(MealResponse.self, from: data) {
                    meals = decodedResponse.meals
                    tableView.reloadData()
                }
            } catch {
                print("Invalid data")
            }
        }
    }
}

class ViewController: UIViewController {
    /// ViewDidLoad
    /// - Can control what happens i.e tableView.start
    /// vs.
    /// ViewController
    /// - UITableViewController
    ///  - Has it's own viewDidLoad
    ///     -self.start
    ///     Here you can assign all the configurations off the bat

    var cell = "cell"
    var vm = ViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.vm.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cell)
        vm.tableView.delegate = self
        vm.tableView.dataSource = self
        
        setupLayoutConstraints()

        Task {
            await vm.loadData()
        }
    }

    func setupLayoutConstraints() {
        view.addSubview(vm.tableView)
        vm.tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            vm.tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            vm.tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            vm.tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            vm.tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor)
        ])
    }

    func showError() {
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
}
// Set up TableView
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.meals.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cell, for: indexPath)
        cell.imageView?.translatesAutoresizingMaskIntoConstraints = false
        cell.imageView?.heightAnchor.constraint(equalToConstant: 40).isActive = true
        cell.imageView?.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 10).isActive = true
        cell.imageView?.widthAnchor.constraint(equalToConstant: 40).isActive = true
        let meal = vm.meals[indexPath.row]
        cell.textLabel?.text = meal.unwrStrMeal
        cell.textLabel?.translatesAutoresizingMaskIntoConstraints = false
        cell.textLabel?.leadingAnchor.constraint(equalTo: cell.imageView!.trailingAnchor, constant: 10).isActive = true
        cell.imageView?.kf.setImage(
            with: URL(string: meal.unwrStrMealThumb),
            placeholder: UIImage(systemName: "photo"),
            options: [
                .transition(.fade(1)),
                .cacheOriginalImage
            ]
        ) { result in
            switch result {
            case .success(_):
                print("image loaded")
            case .failure(let error):
                print("Error: \(error)")
            }
        }
        cell.imageView?.contentMode = .scaleAspectFill
        cell.imageView?.layer.masksToBounds = true
        cell.imageView?.clipsToBounds = true

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.id = vm.meals[indexPath.row].unwrIdMeal
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

