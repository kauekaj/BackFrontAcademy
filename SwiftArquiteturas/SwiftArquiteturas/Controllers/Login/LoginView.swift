//
//  LoginView.swift
//  SwiftArquiteturas
//
//  Created by Kaue de Assis Jacyntho on 27/12/22.
//

import Foundation
import UIKit

class LoginView: UIView {
        
    //MARK: - Properties

    lazy var emailLabel: UILabel = {
       let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.text = "Email"
        element.textColor = .black
        element.textAlignment = .left
        element.font = UIFont.systemFont(ofSize: 17)
        return element
    }()
    
    lazy var emailTextField: UITextField = {
       let element = UITextField()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.layer.cornerRadius = 5
        element.layer.borderColor = UIColor.black.cgColor
        element.layer.borderWidth = 1
        element.backgroundColor = .systemGray4
        element.textColor = .darkGray
        element.layer.borderWidth = 1
        element.placeholder = "Digite seu email"
        element.keyboardType = .emailAddress
        element.setLeftPaddingPoints(15)
        return element
    }()
    
    lazy var passwordLabel: UILabel = {
       let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.text = "Senha"
        element.textColor = .black
        element.textAlignment = .left
        element.font = UIFont.systemFont(ofSize: 17)
        return element
    }()
    
    lazy var passwordTextField: UITextField = {
       let element = UITextField()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.layer.cornerRadius = 5
        element.layer.borderColor = UIColor.black.cgColor
        element.layer.borderWidth = 1
        element.backgroundColor = .systemGray4
        element.textColor = .darkGray
        element.layer.borderWidth = 1
        element.placeholder = "Digite sua senha"
        element.keyboardType = .default
        element.setLeftPaddingPoints(15)
        return element
    }()
    
    lazy var loginButton: UIButton = {
       let element = UIButton()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.setTitle("Entrar", for: .normal)
        element.backgroundColor = .systemBlue
        element.layer.cornerRadius = 10
        return element
    }()
    
    lazy var registerButton: UIButton = {
       let element = UIButton()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.setTitle("Cadastrar", for: .normal)
        element.backgroundColor = .systemBlue
        element.layer.cornerRadius = 10
        return element
    }()

    
    //MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .viewBackgroundColor
        
        setVisualElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Set Visual elements
    func setVisualElements() {
        self.addSubview(emailLabel)
        self.addSubview(emailTextField)
        self.addSubview(passwordLabel)
        self.addSubview(passwordTextField)
        self.addSubview(loginButton)
        self.addSubview(registerButton)
        
        NSLayoutConstraint.activate([
            emailLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            emailLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            emailLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 8),
            emailTextField.leadingAnchor.constraint(equalTo: emailLabel.leadingAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: emailLabel.trailingAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: 40),
            
            passwordLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 12),
            passwordLabel.leadingAnchor.constraint(equalTo: emailLabel.leadingAnchor),
            passwordLabel.trailingAnchor.constraint(equalTo: emailLabel.trailingAnchor),
            
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 8),
            passwordTextField.leadingAnchor.constraint(equalTo: emailLabel.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: emailLabel.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 40),
            loginButton.leadingAnchor.constraint(equalTo: emailLabel.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: emailLabel.trailingAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 40),
            
            registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
            registerButton.leadingAnchor.constraint(equalTo: emailLabel.leadingAnchor),
            registerButton.trailingAnchor.constraint(equalTo: emailLabel.trailingAnchor),
            registerButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    //MARK: - Actions

}
