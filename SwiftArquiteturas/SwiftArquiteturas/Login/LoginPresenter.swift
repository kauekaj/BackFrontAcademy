//
//  LoginPresenter.swift
//  SwiftArquiteturas
//
//  Created by Kaue de Assis Jacyntho on 26/12/22.
//

import Foundation

protocol LoginPresenterDelegate {
    func showMessage(title: String, message: String)
    func goHome()
}

class LoginPresenter {
    
    var delegate: LoginPresenterDelegate?
    
    func login(userModel: UserModel) {
        let manager = UserManager(business: UserBusiness())
        manager.login(email: userModel.email,
                      password: userModel.password) { [weak self] userModel in
            self?.goHome()
        } failureHandler: { [weak self] error in
            if let error = error {
                self?.delegate?.showMessage(title: "Erro",
                                            message: error.localizedDescription)
            }
            
        }
    }
    
    func goHome() {
        self.delegate?.goHome()
    }
}
