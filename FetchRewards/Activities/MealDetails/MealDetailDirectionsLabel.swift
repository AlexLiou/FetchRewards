//
//  MealDetailDirectionsLabel.swift
//  FetchRewards
//
//  Created by Alex Liou on 7/4/22.
//

import UIKit

class MealDetailDirectionsLabel: UILabel {

    init() {
        super.init(frame: .zero)
        self.text = "Directions"
        self.font = .boldSystemFont(ofSize: 18)
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
