//
//  RegisterViewController.swift
//  MessageApp
//
//  Created by Kaue de Assis Jacyntho on 07/11/22.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    var registerScreen: RegisterScreen?
    
    var auth: Auth?
    
    override func loadView() {
        registerScreen = RegisterScreen()
        view = registerScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerScreen?.configTextFieldDelegate(delegate: self)
        registerScreen?.delegate(delegate: self)
        auth = Auth.auth()
    }
    
}

extension RegisterViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        registerScreen?.validateTextfields()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension RegisterViewController: RegisterScreenProtocol {
    func actionBackButton() {
        print("did tap backButton")
        navigationController?.popViewController(animated: true)
    }
    
    func actionRegisterButton() {
        
        let email: String = registerScreen?.emailTextField.text ?? ""
        let password: String = registerScreen?.passwordTextField.text ?? ""

        
        auth?.createUser(withEmail: email, password: password, completion: { result, error in
            if error != nil {
                print("Error ao cadastrar")
            } else {
                print("Sucesso ao cadastrar")
            }
        })
    }
    
    
}
