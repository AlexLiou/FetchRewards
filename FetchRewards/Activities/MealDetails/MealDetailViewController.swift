//
//  MealDetailViewController.swift
//  FetchRewards
//
//  Created by Alex Liou on 7/1/22.
//

import UIKit

protocol MealDetailView: AnyObject {
    func show(_ MealDetails: [MealDetail])
}

extension MealDetailViewController {
    class ViewModel {
        let urlString = "https://www.themealdb.com/api/json/v1/1/lookup.php?i="
        var id: String?
        weak var view: MealDetailView?

        init(id: String, view: MealDetailView?) {
            self.id = id
            self.view = view
        }

        func loadData() async {
            guard let url = URL(string: urlString + id!) else {
                print("Invalid URL")
                return
            }
            print(url)

            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                if let decodedResponse = try? JSONDecoder().decode(MealDetailResponse.self, from: data) {
                    let meals = decodedResponse.meals
                    print(meals)
                    self.view?.show(meals)
                }
            } catch {
                print("Invalid data")
            }
        }
        
        
    }
}

class MealDetailViewController: UIViewController, MealDetailView {
    var id: String?
    var mealDetails: [MealDetail] = []
    
    lazy var scrollView: UIScrollView = { [weak self] in
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        return view
    }()

    lazy var contentView: UIView = { [weak self] in
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = mealDetails[0].strMeal
        label.font = .boldSystemFont(ofSize: 30)
        label.numberOfLines = 0
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var topImageView: UIImageView = { [weak self] in
        let imageView = UIImageView()
        imageView.kf.setImage(with: URL(string: mealDetails[0].strMealThumb)) { result in
            switch result {
            case .success(let value):
                print("Image: \(value.image). Got from: \(value.cacheType)")
            case .failure(let error):
                print("Error: \(error)")
            }
        }
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.sizeToFit()
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 1.5
        imageView.layer.borderColor = UIColor.black.cgColor
        return imageView
    }()

    lazy var ingredientsLabel: UILabel = { [weak self] in
        let label = UILabel()
        label.text = "Ingredients"
        label.font = .boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var listView: UIView = {
        return generateList()
    }()

    lazy var directionsLabel: UILabel = { [weak self] in
        let label = UILabel()
        label.text = "Directions"
        label.font = .boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var directionsTextLabel: UILabel = { [weak self] in
        let label = UILabel()
        label.text = mealDetails[0].strInstructions
        label.numberOfLines = 0
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let vm = ViewModel(id: id!, view: self)
        Task {
            await vm.loadData()
            setUpViews()
        }
    }

    func show(_ mealDetail: [MealDetail]) {
        mealDetails = mealDetail
    }
}
