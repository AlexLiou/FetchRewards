//
//  MealDetailDirectionsTextLabel.swift
//  FetchRewards
//
//  Created by Alex Liou on 7/4/22.
//

import UIKit

class MealDetailsDirectionsTextLabel: UILabel {
    fileprivate let directions: String

    init(directions: String) {
        self.directions = directions
        super.init(frame: .zero)

        self.text = self.directions
        self.numberOfLines = 0
        self.sizeToFit()
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
