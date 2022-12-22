//
//  UserManager.swift
//  SwiftArquiteturas
//
//  Created by Kaue de Assis Jacyntho on 22/12/22.
//

import Foundation

protocol UserManagerProtocol {
    func register(email: String, password: String,
                  successHandler: @escaping(UserModel) -> Void,
                  failureHandler: @escaping(Error?) -> Void)
    
    func login(email: String, password: String,
                  successHandler: @escaping(UserModel) -> Void,
                  failureHandler: @escaping(Error?) -> Void)
    
//    func login(email: String, password: String, completionHandler: @escaping(Result<UserModel, Error>) -> Void)
}

class UserManager: UserManagerProtocol {
    
    let business: UserBusinessProtocol
    
    init(business: UserBusinessProtocol) {
        self.business = business
    }
    
    func register(email: String, password: String,
                  successHandler: @escaping (UserModel) -> Void,
                  failureHandler: @escaping (Error?) -> Void) {
        
        business.register(email: email, password: password) { result in
            switch result {
                
            case .success(let userModel):
                successHandler(userModel)
            case .failure(let error):
                failureHandler(error)
            }
        }
        
    }
    
    func login(email: String, password: String,
                  successHandler: @escaping (UserModel) -> Void,
                  failureHandler: @escaping (Error?) -> Void) {
        
        business.login(email: email, password: password) { result in
            switch result {
                
            case .success(let userModel):
                successHandler(userModel)
            case .failure(let error):
                failureHandler(error)
            }
        }
        
    }
    
//    func login(email: String, password: String, completionHandler: @escaping (Result<UserModel, Error>) -> Void) {
//
//
//        business.register(email: email, password: password) { result in
//            switch result {
//
//            case .success(let userModel):
//                completionHandler(.success(userModel))
//            case .failure(let error):
//                completionHandler(.failure(error))
//            }
//        }
//    }
    
 
    
}
