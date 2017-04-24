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
    case user(String)                   // 查詢用戶
    case newUser([String:String])       // 新增用戶
    case contents(Int)                  // 查詢所有Note
    case deleteContent(Int)             // 刪除單筆Note
    case addContent([String:Any])       // 新增一筆Note
    case modifyContent(Int,[String:Any])    // 修改一筆Note
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
        case .deleteContent(let id):
            return "content/\(id)"
        case .addContent:
            return "addcontent"
        case .modifyContent(let id, _):
            return "content/\(id)"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .user, .contents:
            return .get
        case .newUser, .addContent:
            return .post
        case .deleteContent:
            return .delete
        case .modifyContent:
            return .put
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
        case .addContent(let json):
            return json
        case .modifyContent(_, let json):
            return json
        default:
            return nil
        }
    }
    
    public var parameterEncoding: ParameterEncoding {
        switch self {
        case .user, .contents, .deleteContent:
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
