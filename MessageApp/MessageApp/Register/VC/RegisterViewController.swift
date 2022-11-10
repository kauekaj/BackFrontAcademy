//
//  RegisterViewController.swift
//  MessageApp
//
//  Created by Kaue de Assis Jacyntho on 07/11/22.
//

import UIKit

class RegisterViewController: UIViewController {

    var registerScreen: RegisterScreen?
    
    override func loadView() {
        registerScreen = RegisterScreen()
        view = registerScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerScreen?.configTextFieldDelegate(delegate: self)
        registerScreen?.delegate(delegate: self)
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
        print("did tap registerButton")
    }
    
    
}
