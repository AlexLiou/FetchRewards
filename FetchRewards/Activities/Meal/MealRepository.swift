//
//  MealRepository.swift
//  FetchRewards
//
//  Created by Alex Liou on 7/4/22.
//

import Foundation

protocol MealRepoable {
    func getMeals(_ closure: @escaping (Result<[Meal], Error>) -> Void)
}

struct GetMealRequest: APIRequest {
    typealias SuccessResponse = MealResponse
    typealias FailureResponse = AnyResponse

    var method: HTTPMethod { .get }
    var baseURL: String { "https://www.themealdb.com/api/json/v1/1/filter.php?c=Dessert" }
    var path: String { "" }
}

class MealRepository: MealRepoable {

    static var shared = MealRepository()
    var api: APIClient = URLSessionAPIClient(session: URLSession.shared)

    func getMeals(_ closure: @escaping (Result<[Meal], Error>) -> Void) {
        let request = GetMealRequest()
        api.send(request: request) { result in
            switch result {
            case .success(let response):
                closure(.success(response.meals))
            case .failure(let error):
                closure(.failure(error))
            }
        }
    }

    private init() {}
}
