//
//  LoginViewController.swift
//  SwiftArquiteturas
//
//  Created by Kaue de Assis Jacyntho on 22/12/22.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    
    //MARK: - Properties
    
    lazy var loginView: LoginView = {
        let view = LoginView(frame: .zero)
        
        return view
    }()
    
    //MARK: - Overrides

    override func loadView() {
        self.view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Login"
    }
    
}
