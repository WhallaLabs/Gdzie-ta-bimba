//
//  ApiProvider.swift
//  peka
//
//  Created by Tomasz Pikć on 28/07/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import Foundation
import RxSwift
import SwiftyJSON

final class ApiProvider: RestApiProvider {
    private let endpoint: String
    private let headersProvider: HttpHeadersProvider
    private let formBodyBuilder: FormBodyBuilder
    
    init(endpoint: String, httpHeadersProvider: HttpHeadersProvider, formBodyBuilder: FormBodyBuilder) {
        self.endpoint = endpoint
        self.headersProvider = httpHeadersProvider
        self.formBodyBuilder = formBodyBuilder
    }
    
    func get<T: ObjectMappable>(resource: String, mapper: T) -> Observable<T.T> {
        return self.get(resource, queryParameters: [ : ], mapper: mapper)
    }
    
    func get<T: ObjectMappable>(resource: String, queryParameters: [String : String], mapper: T) -> Observable<T.T> {
        let request = RequestBuilder(endpoint: self.endpoint, formBodyBuilder: self.formBodyBuilder)
            .add(resource: resource)
            .add(queryParameters: queryParameters)
            .setMethod(.GET)
        
        return self.execute(request, mapper: mapper)
    }
    
    func post<T: ObjectMappable>(resource: String, mapper: T) -> Observable<T.T> {
        return self.post(resource, json: nil, mapper: mapper)
    }
    
    func post<T : ObjectMappable, U : JsonMappable, R where R == U.T>(resource: String, bodyObject: R, bodyMapper: U, resultMapper: T) -> Observable<T.T> {
        guard let json = bodyMapper.mapToJson(bodyObject) else {
            return Observable.error(ApiProviderError.JsonMapping)
        }
        return self.post(resource, json: json, mapper: resultMapper)
    }
    
    func post<T: ObjectMappable>(resource: String, json: JSON?, mapper: T) -> Observable<T.T> {
        let request = RequestBuilder(endpoint: self.endpoint, formBodyBuilder: self.formBodyBuilder)
            .add(resource: resource)
            .add(json: json)
            .setMethod(.POST)
        
        return self.execute(request, mapper: mapper)
    }
    
    func post<T: ObjectMappable>(resource: String, bodyParameters: [HttpBodyParameter], mapper: T) -> Observable<T.T> {
        let request = RequestBuilder(endpoint: self.endpoint, formBodyBuilder: self.formBodyBuilder)
            .add(resource: resource)
            .add(bodyParameters: bodyParameters)
            .setMethod(.POST)
        
        return self.execute(request,mapper: mapper)
    }
    
    func put<T: ObjectMappable>(resource: String, mapper: T) -> Observable<T.T> {
        return self.put(resource, json: nil, mapper: mapper)
    }
    
    func put<T : ObjectMappable, U : JsonMappable, R where R == U.T>(resource: String, bodyObject: R, bodyMapper: U, resultMapper: T) -> Observable<T.T> {
        guard let json = bodyMapper.mapToJson(bodyObject) else {
            return Observable.error(ApiProviderError.JsonMapping)
        }
        return self.put(resource, json: json, mapper: resultMapper)
    }
    
    func put<T: ObjectMappable>(resource: String, json: JSON?, mapper: T) -> Observable<T.T> {
        let request = RequestBuilder(endpoint: self.endpoint, formBodyBuilder: self.formBodyBuilder)
            .add(resource: resource)
            .add(json: json)
            .setMethod(.PUT)
        
        return self.execute(request, mapper: mapper)
    }
    
    func delete<T: ObjectMappable>(resource: String, mapper: T) -> Observable<T.T> {
        return self.delete(resource, json: nil, mapper: mapper)
    }
    
    func delete<T : ObjectMappable, U : JsonMappable, R where R == U.T>(resource: String, bodyObject: R, bodyMapper: U, resultMapper: T) -> Observable<T.T> {
        guard let json = bodyMapper.mapToJson(bodyObject) else {
            return Observable.error(ApiProviderError.JsonMapping)
        }
        return self.delete(resource, json: json, mapper: resultMapper)
    }
    
    func delete<T: ObjectMappable>(resource: String, json: JSON?, mapper: T) -> Observable<T.T> {
        let request = RequestBuilder(endpoint: self.endpoint, formBodyBuilder: self.formBodyBuilder)
            .add(resource: resource)
            .add(json: json)
            .setMethod(.DELETE)
        
        return self.execute(request, mapper: mapper)
    }
    
    func execute<T: ObjectMappable>(requestBuilder: BodyRequestBuilder, mapper: T) -> Observable<T.T> {
        let headersProvider = self.headersProvider
        let observable: Observable<T.T> = Observable.create { observer in
            let headers = headersProvider.prepareHeaders()
            
            let urlRequest = requestBuilder
                .add(headers: headers)
                .getRequest()
            
            let task = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration()).dataTaskWithRequest(urlRequest) { (data, response, error) in
                if let error = error {
                    observer.onError(error)
                }
                if let response = response as? NSHTTPURLResponse,
                    data = data {
                    let json = JSON(data: data)
                    if requestBuilder.httpMethod.isSuccessResponse(response.statusCode) {
                        if let mappedObject = mapper.mapToObject(json) {
                            observer.onNext(mappedObject)
                        }
                        else {
                            observer.onError(ApiProviderError.JsonMapping)
                        }
                    } else {
                        let error = ApiProviderError.HttpError(status: response.statusCode, json: json)
                        observer.onError(error)
                    }
                } else {
                    observer.onError(ApiProviderError.NoResponse)
                }
                observer.onCompleted()
            }
            task.resume()
            return AnonymousDisposable {
                task.cancel()
            }
        }
        return observable.observeOn(MainScheduler.instance).shareReplayLatestWhileConnected()
    }
}