//
//  MealListTableViewController.swift
//  FetchRewards
//
//  Created by Alex Liou on 7/1/22.
//

import UIKit
@MainActor
class MealListTableViewController: UIViewController {

    lazy var tableView: UITableView = { [weak self] in
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    var vm = MealListTableViewControllerViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MealTableViewCell.self, forCellReuseIdentifier: MealTableViewCell.identifier)
        setUpViews()
        Task {
            await vm.loadData()
            tableView.reloadData()
            print(vm.meals.count)
        }
        tableView.reloadData()
    }

    func setUpViews() {
        view.backgroundColor = UIColor.white
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor)
        ])
    }
}

extension MealListTableViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(vm.meals.count)
        return vm.meals.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MealTableViewCell.identifier, for: indexPath) as? MealTableViewCell else {
            return UITableViewCell(style: .default, reuseIdentifier: MealTableViewCell.identifier)
        }
        let meal = vm.meals[indexPath.row]
        cell.setup(meal)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let meal = vm.meals[indexPath.row]
        let vc = MealDetailViewController()
        vc.id = meal.idMeal
        print(meal)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
