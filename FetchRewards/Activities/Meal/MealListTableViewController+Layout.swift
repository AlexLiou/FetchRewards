//
//  MealListTableViewController+Layout.swift
//  FetchRewards
//
//  Created by Alex Liou on 7/3/22.
//

import UIKit

extension MealListTableViewController {
    func setUpViews() {
        view.backgroundColor = UIColor.white
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor)
        ])
        tableViewDataSource = MealListTableViewDataSource(tableView: tableView, delegate: self)
    }
}
