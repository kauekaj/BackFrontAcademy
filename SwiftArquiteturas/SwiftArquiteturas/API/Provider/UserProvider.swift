//
//  UserProvider.swift
//  SwiftArquiteturas
//
//  Created by Kaue de Assis Jacyntho on 21/12/22.
//

import Foundation
import FirebaseAuth

protocol UserProviderProtocol {
    func login(parameters: [AnyHashable: Any], completionHandler: @escaping(Result<UserModel, Error>) -> Void)
    func register(parameters: [AnyHashable: Any], completionHandler: @escaping(Result<UserModel, Error>) -> Void)
}

class UserProvider: UserProviderProtocol {
    lazy var auth = Auth.auth()
    
    func login(parameters: [AnyHashable : Any], completionHandler: @escaping (Result<UserModel, Error>) -> Void) {
        let body: NSDictionary = parameters[Constants.ParametersKey.body] as? NSDictionary ?? NSDictionary()
        let userModel = body[Constants.ParametersKey.userModel] as? UserModel ?? UserModel()
        
        self.auth.signIn(withEmail: userModel.email, password: userModel.password) { result, error in
            if let error = error {
                completionHandler(.failure(error))
            } else {
                completionHandler(.success(userModel))
            }
        }
    }
    
    func register(parameters: [AnyHashable : Any], completionHandler: @escaping (Result<UserModel, Error>) -> Void) {
        let body: NSDictionary = parameters[Constants.ParametersKey.body] as? NSDictionary ?? NSDictionary()
        let userModel = body[Constants.ParametersKey.userModel] as? UserModel ?? UserModel()
        
        self.auth.createUser(withEmail: userModel.email, password: userModel.password) { result, error in
            if let error = error {
                completionHandler(.failure(error))
            } else {
                completionHandler(.success(userModel))
            }
        }

    }
    
    
}
