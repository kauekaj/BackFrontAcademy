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
    }
    


}
