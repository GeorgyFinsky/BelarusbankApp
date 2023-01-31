//
//  BankProvider.swift
//  BelarusbankApp
//
//  Created by Georgy Finsky on 29.01.23.
//

import Foundation
import Moya

typealias ArrayResponce<T: Decodable> = (([T]) -> Void)
typealias ObjectResponce<T: Decodable> = ((T) -> Void)
typealias Error = ((String) -> Void)

final class BankFacilityProvider {
    private let provider = MoyaProvider<BankAPI>(plugins: [NetworkLoggerPlugin()])
    
    func getATMs(success: @escaping ArrayResponce<ATMModel>, failure: @escaping Error) {
        provider.request(.getAtm) { result in
            switch result {
                case .success(let responce):
                    RealmManager().write(object: RequestRealmModel(code: responce.statusCode, type: .atms))
                    guard let result = try? JSONDecoder().decode([ATMModel].self, from: responce.data) else { return }
                    success(result)
                case .failure(let error):
                    RealmManager().write(object: RequestRealmModel(code: error.errorCode, type: .atms))
                    failure(error.localizedDescription)
            }
        }
    }
    
    func getDepartments(success: @escaping ArrayResponce<DepartmentModel>, failure: @escaping Error) {
        provider.request(.getDepartments) { result in
            switch result {
                case .success(let responce):
                    RealmManager().write(object: RequestRealmModel(code: responce.statusCode, type: .departments))
                    guard let result = try? JSONDecoder().decode([DepartmentModel].self, from: responce.data) else { return }
                    success(result)
                case .failure(let error):
                    RealmManager().write(object: RequestRealmModel(code: error.errorCode, type: .departments))
                    failure(error.localizedDescription)
            }
        }
    }
    
    func getGems(success: @escaping ArrayResponce<GemModel>, failure: @escaping Error) {
        provider.request(.getGems) { result in
            switch result {
                case .success(let responce):
                    RealmManager().write(object: RequestRealmModel(code: responce.statusCode, type: .gems))
                    guard let result = try? JSONDecoder().decode([GemModel].self, from: responce.data) else { return }
                    success(result)
                case .failure(let error):
                    RealmManager().write(object: RequestRealmModel(code: error.errorCode, type: .gems))
                    failure(error.localizedDescription)
            }
        }
    }
    
    func getIngots(success: @escaping ArrayResponce<IngotModel>, failure: @escaping Error) {
        provider.request(.getIngots) { result in
            switch result {
                case .success(let responce):
                    RealmManager().write(object: RequestRealmModel(code: responce.statusCode, type: .ingots))
                    guard let result = try? JSONDecoder().decode([IngotModel].self, from: responce.data) else { return }
                    success(result)
                case .failure(let error):
                    RealmManager().write(object: RequestRealmModel(code: error.errorCode, type: .ingots))
                    failure(error.localizedDescription)
            }
        }
    }
    
    func getNews(success: @escaping ArrayResponce<NewsModel>, failure: @escaping Error) {
        provider.request(.getNews) { result in
            switch result {
                case .success(let responce):
                    RealmManager().write(object: RequestRealmModel(code: responce.statusCode, type: .news))
                    guard let result = try? JSONDecoder().decode([NewsModel].self, from: responce.data) else { return }
                    success(result)
                case .failure(let error):
                    RealmManager().write(object: RequestRealmModel(code: error.errorCode, type: .news))
                    failure(error.localizedDescription)
            }
        }
    }
    
}
