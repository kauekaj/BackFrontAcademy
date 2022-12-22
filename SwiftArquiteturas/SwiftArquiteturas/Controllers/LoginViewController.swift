//
//  LoginViewController.swift
//  SwiftArquiteturas
//
//  Created by Kaue de Assis Jacyntho on 22/12/22.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    
        
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func loginButton(_ sender: Any) {
        let manager = UserManager(business: UserBusiness())
        
        if let email = emailTextField.text,
           let password = passwordTextField.text {
            
            manager.login(email: email, password: password) { userModel in
                self.openHomeView()
            } failureHandler: { error in
                self.showMessage(title: "Erro", message: error?.localizedDescription ?? "")
            }
        }
        
    }
    
    func showMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    func openHomeView() {
        let homeView = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        homeView.modalPresentationStyle = .fullScreen
        self.present(homeView, animated: true)
    }
    
    @IBAction func registerButton(_ sender: Any) {
        self.openRegisterView()
    }
    
    func openRegisterView() {
        let homeView = self.storyboard?.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        homeView.modalPresentationStyle = .fullScreen
        self.present(homeView, animated: true)
    }
}
