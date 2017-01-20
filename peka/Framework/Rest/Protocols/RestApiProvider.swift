//
//  RestApiProvider.swift
//  peka
//
//  Created by Tomasz Pikć on 28/07/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import Foundation
import RxSwift
import SwiftyJSON

protocol RestApiProvider {
    func get<T: ObjectMappable>(_ resource: String, mapper: T) -> Observable<T.T>
    func get<T: ObjectMappable>(_ resource: String, queryParameters: [String : String], mapper: T) -> Observable<T.T>
    func post<T: ObjectMappable>(_ resource: String, mapper: T) -> Observable<T.T>
    func post<T: ObjectMappable>(_ resource: String, json: JSON?, mapper: T) -> Observable<T.T>
    func post<T: ObjectMappable, U: JsonMappable, R>(_ resource: String, bodyObject: R, bodyMapper: U, resultMapper: T) -> Observable<T.T> where R == U.T
    func post<T: ObjectMappable>(_ resource: String, bodyParameters: [HttpBodyParameter], mapper: T) -> Observable<T.T>
    func put<T: ObjectMappable>(_ resource: String, mapper: T) -> Observable<T.T>
    func put<T: ObjectMappable, U: JsonMappable, R>(_ resource: String, bodyObject: R, bodyMapper: U, resultMapper: T) -> Observable<T.T> where R == U.T
    func put<T: ObjectMappable>(_ resource: String, json: JSON?, mapper: T) -> Observable<T.T>
    func delete<T: ObjectMappable>(_ resource: String, mapper: T) -> Observable<T.T>
    func delete<T: ObjectMappable, U: JsonMappable, R>(_ resource: String, bodyObject: R, bodyMapper: U, resultMapper: T) -> Observable<T.T> where R == U.T
    func delete<T: ObjectMappable>(_ resource: String, json: JSON?, mapper: T) -> Observable<T.T>
    
    func execute<T: ObjectMappable>(_ requestBuilder: BodyRequestBuilder, mapper: T) -> Observable<T.T>
}
