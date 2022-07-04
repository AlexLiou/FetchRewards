//
//  MealDetailTitleLabel.swift
//  FetchRewards
//
//  Created by Alex Liou on 7/4/22.
//

import UIKit

class MealDetailTitleLabel: UILabel {
    fileprivate let title: String

    init(title: String) {
        self.title = title
        super.init(frame: .zero)
        self.text = self.title
        self.font = .boldSystemFont(ofSize: 30)
        self.numberOfLines = 0
        self.sizeToFit()
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
