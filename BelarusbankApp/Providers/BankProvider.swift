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
                    guard let result = try? JSONDecoder().decode([ATMModel].self, from: responce.data) else { return }
                    success(result)
                case .failure(let error):
                    failure(error.localizedDescription)
            }
        }
    }
    
    func getDepartments(success: @escaping ArrayResponce<DepartmentModel>, failure: @escaping Error) {
        provider.request(.getDepartments) { result in
            switch result {
                case .success(let responce):
                    guard let result = try? JSONDecoder().decode([DepartmentModel].self, from: responce.data) else { return }
                    success(result)
                case .failure(let error):
                    failure(error.localizedDescription)
            }
        }
    }
    
    func getGems(success: @escaping ArrayResponce<GemModel>, failure: @escaping Error) {
        provider.request(.getGems) { result in
            switch result {
                case .success(let responce):
                    guard let result = try? JSONDecoder().decode([GemModel].self, from: responce.data) else { return }
                    success(result)
                case .failure(let error):
                    failure(error.localizedDescription)
            }
        }
    }
    
    func getIngots(success: @escaping ArrayResponce<IngotModel>, failure: @escaping Error) {
        provider.request(.getIngots) { result in
            switch result {
                case .success(let responce):
                    guard let result = try? JSONDecoder().decode([IngotModel].self, from: responce.data) else { return }
                    success(result)
                case .failure(let error):
                    failure(error.localizedDescription)
            }
        }
    }
    
    func GetNews(success: @escaping ArrayResponce<NewsModel>, failure: @escaping Error) {
        provider.request(.getNews) { result in
            switch result {
                case .success(let responce):
                    guard let result = try? JSONDecoder().decode([NewsModel].self, from: responce.data) else { return }
                    success(result)
                case .failure(let error):
                    failure(error.localizedDescription)
            }
        }
    }
    
}
