//
//  BankAPI.swift
//  BelarusbankApp
//
//  Created by Georgy Finsky on 29.01.23.
//

import Foundation
import Moya

enum BankAPI {
    case getAtm
    case getDepartments
    case getGems
    case getIngots
}

extension BankAPI: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://belarusbank.by/api")!
    }
    
    var path: String {
        switch self {
            case .getAtm:
                return "atm"
            case .getDepartments:
                return "filials_info"
            case .getGems:
                return "getgems"
            case .getIngots:
                return "getinfodrall"
        }
    }
    
    var method: Moya.Method {
        switch self {
            case .getAtm, .getDepartments, .getGems, .getIngots:
                return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Moya.Task {
        guard let parameters else { return .requestPlain }
        
        return .requestParameters(parameters: parameters, encoding: encoding)
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var parameters: [String: Any]? {
        return nil
    }
    
    var encoding: ParameterEncoding {
        switch self {
            case .getAtm, .getDepartments, .getGems, .getIngots:
                return URLEncoding.queryString
        }
    }
    
}
