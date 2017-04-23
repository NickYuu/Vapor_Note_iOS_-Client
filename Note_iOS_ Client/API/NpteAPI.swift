//
//  NoteAPI.swift
//  Note_iOS_ Client
//
//  Created by TsungHan on 2017/4/22.
//  Copyright © 2017年 TsungHan. All rights reserved.
//

import Moya


let NoteProvider = RxMoyaProvider<NoteAPI>()


// MARK: - Provider support
private extension String {
    var urlEscaped: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
}

public enum NoteAPI {
    case user(String)
    case newUser([String:String])
    case contents(Int)
}


extension NoteAPI: TargetType {
    public var baseURL: URL { return URL(string: "http://127.0.0.1:8080/")! }
    
    
    public var path: String {
        switch self {
        case .user:
            return "user"
        case .newUser:
            return "user"
        case .contents:
            return "content"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .user, .contents:
            return .get
        case .newUser:
            return .post
        }
    }
    
    public var parameters: [String: Any]? {
        switch self {
        case .user(let acc):
            return ["acc": acc]
        case .newUser(let json):
            return json
        case .contents(let id):
            return ["userid": id]
//        default:
//            return nil
        }
    }
    
    public var parameterEncoding: ParameterEncoding {
        switch self {
        case .user, .contents:
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
        
        
    }
    
    public var task: Task {
        return .request
    }
    
    public var validate: Bool {
        switch self {
        default:
            return false
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
}
