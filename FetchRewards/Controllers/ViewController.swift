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

        func loadData() async {
            guard let url = URL(string: urlString) else {
                print("Invalid URL")
                return
            }

            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                if let decodedResponse = try? JSONDecoder().decode(MealResponse.self, from: data) {
                    meals = decodedResponse.meals
                }
            } catch {
                print("Invalid data")
            }
        }
    }
}

class ViewController: UIViewController {
    var cell = "cell"
    var vm = ViewModel()
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cell)
        tableView.delegate = self
        tableView.dataSource = self
        
        setupLayoutConstraints()

        Task {
            await vm.loadData()
            tableView.reloadData()
        }
    }

    func setupLayoutConstraints() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor)
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
        cell.imageView?.contentMode = .scaleAspectFill
        cell.imageView?.layer.masksToBounds = true
        cell.imageView?.clipsToBounds = true

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

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.id = vm.meals[indexPath.row].unwrIdMeal
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

