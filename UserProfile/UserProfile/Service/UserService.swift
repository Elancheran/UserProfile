//
//  UserService.swift
//  UserLogin
//
//  Created by Elancheran, Ravi on 04/07/21.
//

import Foundation
import RxSwift

protocol UserServiceType {
    func fetchUserDetails() -> Observable<[UserDetail]>
}

class UserService: UserServiceType {
    
    func fetchUserDetails() -> Observable<[UserDetail]> {
        let request = urlRequest()
        return Observable.create { observer in
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let httpResponse = response as? HTTPURLResponse {
                    let statusCode = httpResponse.statusCode
                    do {
                        let data = data ?? Data()
                        if (200...399).contains(statusCode) {
                            let userDetail = try JSONDecoder().decode([UserDetail].self, from:data)
                            observer.onNext(userDetail)
                        }
                        else {
                            observer.onError(error!)
                        }
                    } catch {
                        observer.onError(error)
                    }
                }
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
    private func urlRequest() -> URLRequest {
        let url = "http://www.json-generator.com/api/json/get/ceiNKFwyaa?indent=2"
        let serviceUrl = URL(string: url)!
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "GET"
        return request
    }
}
