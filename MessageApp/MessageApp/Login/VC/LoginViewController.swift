//
//  ViewController.swift
//  MessageApp
//
//  Created by Kaue de Assis Jacyntho on 04/11/22.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    var loginScreen: LoginScreen?
    var auth: Auth?
    var alert: Alert?

    override func loadView() {
        loginScreen = LoginScreen()
        view = loginScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginScreen?.delegate(delegate: self)
        loginScreen?.configTextFieldDelegate(delegate: self)
        auth = Auth.auth()
        alert = Alert(controller: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        loginScreen?.validateTextfields()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}

extension LoginViewController: LoginScreenProtocol {
    func actionLoginButton() {
        
        guard let login = loginScreen else { return }

        auth?.signIn(withEmail: login.getEmail(), password: login.getPassword(), completion: { user, error in
            if error != nil {
                self.alert?.getAlert(title: "Atençao", message: "Dados incorretos!")
            } else {
                if user == nil {
                    self.alert?.getAlert(title: "Atençao", message: "Tivemos um problema inesperado. Tente novamente mais tarde.")
                } else {
                    self.alert?.getAlert(title: "Parabéns", message: "Login efetuado com sucesso!")
                }
            }
        })
        
    }
    
    func actionRegisterButton() {
        let vc = RegisterViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
