//
//  MealDetailViewController+Layout.swift
//  FetchRewards
//
//  Created by Alex Liou on 7/3/22.
//

import UIKit

extension MealDetailScrollView {
    
    func setUpViews(titleLabel: MealDetailTitleLabel) {
        addSubview(contentView)
        contentView.frame = frame

//        scrollView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: self.view.frame.width, height: self.view.frame.height, enableInsets: false)

        self.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        self.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        self.topAnchor.constraint(equalTo: topAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true

//        contentView.anchor(top: scrollView.topAnchor, left: scrollView.leftAnchor, bottom: scrollView.bottomAnchor, right: scrollView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: scrollView.frame.size
//            .width, height: scrollView.frame.size.height, enableInsets: false)

        contentView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        contentView.addSubview(titleLabel)
        titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 3/4).isActive = true
        titleLabel.frame = frame

        contentView.addSubview(topImageView)
        topImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        topImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 25).isActive = true
        topImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 3/4).isActive = true
        let targetSize = CGSize(width: frame.size.width, height: 250)
        topImageView.image = topImageView.image?.scalePreservingAspectRatio(targetSize: targetSize)

        contentView.addSubview(ingredientsLabel)
        ingredientsLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        ingredientsLabel.topAnchor.constraint(equalTo: topImageView.bottomAnchor, constant: 25).isActive = true
        ingredientsLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 3/4).isActive = true

        contentView.addSubview(listView)
        listView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        listView.topAnchor.constraint(equalTo: ingredientsLabel.bottomAnchor, constant: 25).isActive = true
        listView.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true

        contentView.addSubview(directionsLabel)
        directionsLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        directionsLabel.topAnchor.constraint(equalTo: listView.bottomAnchor, constant: 25).isActive = true
        directionsLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 3/4).isActive = true

        contentView.addSubview(directionsTextLabel)
        directionsTextLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        directionsTextLabel.topAnchor.constraint(equalTo: directionsLabel.bottomAnchor, constant: 25).isActive = true
        directionsTextLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 3/4).isActive = true
        directionsTextLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
}
