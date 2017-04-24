//
//  NoteData.swift
//  Note_iOS_ Client
//
//  Created by TsungHan on 2017/4/22.
//  Copyright © 2017年 TsungHan. All rights reserved.
//

import Moya
import RxSwift
import SwiftyJSON
import ObjectMapper

struct NoteData {
    
    static func getUser(_ acc: String) -> Observable<User> {
        return NoteProvider
                .request(.user(acc))
                .mapObject(User.self)
    }
    
    static func newUser(_ user:User) -> Observable<User> {
        return NoteProvider
                .request(.newUser(user.toDic()))
                .mapObject(User.self)
    }
    
    static func contents(_ userId:Int) -> Observable<[Content]> {
        return NoteProvider
                .request(.contents(userId))
                .mapResultArray(Content.self)
    }
    
    static func deleteContent(_ userId:Int) -> Observable<([Content], Bool)> {
        return NoteProvider
                .request(.deleteContent(userId))
                .deleteContent(Content.self)
    }
    
    static func addContent(_ content:Content) -> Observable<([Content], Bool)> {
        return NoteProvider
            .request(.addContent(content.toDic()))
            .deleteContent(Content.self)
    }
    
    static func modifyContent(_ content:Content) -> Observable<([Content], Bool)> {
        let id = content.id!
        return NoteProvider
            .request(.modifyContent(id, content.toDic()))
            .deleteContent(Content.self)
    }
    
}

extension Response {
    
    func getJson() throws -> JSON {
        
        let json = JSON(data: data)
        return json
    }
    
    func checkDelete() -> Bool {
        let json = JSON(data: data)
        
        return json["status"] == "1"
    }
    
    public func mapObject<T: BaseMappable>(_ type: T.Type) throws -> T {
        
        let user = JSON(data: self.data)["data"]

        guard let object = Mapper<T>().map(JSONObject: user.dictionaryObject) else {
            throw MoyaError.jsonMapping(self)
        }
        return object
    }
    
    public func mapResultArray<T: BaseMappable>(_ type: T.Type) throws -> [T] {
        let json = JSON(data: self.data)
        //let jsonArray = json["result"]
        
        guard let array = json.arrayObject as? [[String: Any]],
              let objects = Mapper<T>().mapArray(JSONArray: array) else {
                throw MoyaError.jsonMapping(self)
        }
        return objects
    }
    
    public func mapDataArray<T: BaseMappable>(_ type: T.Type) throws -> [T] {
        let json = JSON(data: self.data)
        let jsonArray = json["data"]
        
        guard let array = jsonArray.arrayObject as? [[String: Any]],
            let objects = Mapper<T>().mapArray(JSONArray: array) else {
                throw MoyaError.jsonMapping(self)
        }
        return objects
    }
    
}

extension ObservableType where E == Response {
    
    public func mapObject<T: BaseMappable>(_ type: T.Type) -> Observable<T> {
        return flatMap { response -> Observable<T> in
            return Observable.just(try response.mapObject(T.self))
        }
    }
    
    public func mapResultArray<T: BaseMappable>(_ type: T.Type) -> Observable<[T]> {
        return flatMap { response -> Observable<[T]> in
            return Observable.just(try response.mapResultArray(T.self))
        }
    }
    
    public func deleteContent<T: BaseMappable>(_ type: T.Type) -> Observable<([T],Bool)> {
        return flatMap { response -> Observable<([T],Bool)> in
            return Observable.just((try response.mapDataArray(T.self), response.checkDelete()))
        }
    }
    
}
