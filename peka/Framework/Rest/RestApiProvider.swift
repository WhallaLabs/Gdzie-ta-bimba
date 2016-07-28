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
    func get<T: ObjectMappable>(resource: String, mapper: T) -> Observable<T.T>
    func get<T: ObjectMappable>(resource: String, queryParameters: [String : String], mapper: T) -> Observable<T.T>
    func post<T: ObjectMappable>(resource: String, mapper: T) -> Observable<T.T>
    func post<T: ObjectMappable>(resource: String, json: JSON?, mapper: T) -> Observable<T.T>
    func post<T: ObjectMappable>(resource: String, bodyParameters: [HttpBodyParameter], mapper: T) -> Observable<T.T>
    func put<T: ObjectMappable>(resource: String, mapper: T) -> Observable<T.T>
    func put<T: ObjectMappable>(resource: String, json: JSON?, mapper: T) -> Observable<T.T>
    func delete<T: ObjectMappable>(resource: String, mapper: T) -> Observable<T.T>
    func delete<T: ObjectMappable>(resource: String, json: JSON?, mapper: T) -> Observable<T.T>
    
    func execute<T: ObjectMappable>(requestBuilder: BodyRequestBuilder, mapper: T) -> Observable<T.T>
}