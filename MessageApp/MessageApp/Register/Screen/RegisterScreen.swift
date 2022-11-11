//
//  RegisterScreen.swift
//  MessageApp
//
//  Created by Kaue de Assis Jacyntho on 08/11/22.
//

import UIKit

protocol RegisterScreenProtocol: AnyObject {
    func actionBackButton()
    func actionRegisterButton()
}

class RegisterScreen: UIView {
    
    weak private var delegate: RegisterScreenProtocol?
    
    func delegate(delegate: RegisterScreenProtocol?) {
        self.delegate = delegate
    }
    
    
    lazy var backButton: UIButton = {
        let element = UIButton()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.setImage(UIImage(named: "back"), for: .normal)
        element.addTarget(self, action: #selector(tappedBackButton), for: .touchUpInside)
        return element
    }()
    
    lazy var addUserImageView: UIImageView = {
        let element = UIImageView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.image = UIImage(named: "usuario")
        element.contentMode = .scaleAspectFit
        return element
    }()
    
    lazy var emailTextField: UITextField = {
        let element = UITextField()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.autocorrectionType = .no
        element.autocapitalizationType = .none
        element.backgroundColor = .white
        element.borderStyle = .roundedRect
        element.keyboardType = .emailAddress
        element.placeholder = "Digite seu Email"
        element.font = UIFont.systemFont(ofSize: 14)
        element.textColor = .darkGray
        return element
    }()
    
    lazy var passwordTextField: UITextField = {
        let element = UITextField()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.autocorrectionType = .no
        element.autocapitalizationType = .none
        element.backgroundColor = .white
        element.borderStyle = .roundedRect
        element.keyboardType = .default
        element.placeholder = "Digite sua senha"
        element.isSecureTextEntry = true
        element.font = UIFont.systemFont(ofSize: 14)
        element.textColor = .darkGray
        return element
    }()
    
    lazy var registerButton: UIButton = {
        let element = UIButton()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.setTitle("Cadastar", for: .normal)
        element.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        element.setTitleColor(.white, for: .normal)
        element.clipsToBounds = true
        element.layer.cornerRadius = 7.5
        element.backgroundColor = UIColor(red: 3/255, green: 58/255, blue: 51/255, alpha: 1.0)
        element.addTarget(self, action: #selector(tappedRegisterButton), for: .touchUpInside)
        return element
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configBackground()
        configSuperView()
        
        configAddUserImageViewConstraints()
        configBackButtonConstraints()
        configEmailTextFieldConstraints()
        configPasswordTextFieldConstraints()
        configRegisterButtonConstraints()
        
//        setupConstraints()
        configButtonEnable(false)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configBackground() {
        backgroundColor = UIColor(red: 24/255, green: 117/255, blue: 104/255, alpha: 1.0)
    }
    
    private func configSuperView() {
        addSubview(backButton)
        addSubview(addUserImageView)
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(registerButton)
    }
    
    public func configTextFieldDelegate(delegate: UITextFieldDelegate) {
        self.emailTextField.delegate = delegate
        self.passwordTextField.delegate = delegate
    }
    
    @objc
    private func tappedBackButton() {
        delegate?.actionBackButton()
    }
    
    @objc
    private func tappedRegisterButton() {
        delegate?.actionRegisterButton()
    }
    
    public func validateTextfields() {
        let email: String = emailTextField.text ?? ""
        let passaword: String = passwordTextField.text ?? ""
        
        if !email.isEmpty && !passaword.isEmpty {
            configButtonEnable(true)
        } else {
            configButtonEnable(false)
        }
    }
    
    private func configButtonEnable(_ enable: Bool) {
        if enable {
            registerButton.setTitleColor(.white, for: .normal)
            registerButton.isEnabled = true
        } else {
            registerButton.setTitleColor(.lightGray, for: .normal)
            registerButton.isEnabled = false
        }
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            addUserImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            addUserImageView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            addUserImageView.widthAnchor.constraint(equalToConstant: 150),
            addUserImageView.heightAnchor.constraint(equalToConstant: 150),

            backButton.topAnchor.constraint(equalTo: addUserImageView.topAnchor),
            backButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),

            emailTextField.topAnchor.constraint(equalTo: addUserImageView.bottomAnchor, constant: 10),
            emailTextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            emailTextField.heightAnchor.constraint(equalToConstant: 45),

            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 10),
            passwordTextField.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 45),

            registerButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 10),
            registerButton.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            registerButton.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            registerButton.heightAnchor.constraint(equalToConstant: 45),
            
        ])
    }
    
    func configAddUserImageViewConstraints() {
        addUserImageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(20)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(150)
        }
    }
    
    func configBackButtonConstraints() {
        backButton.snp.makeConstraints { make in
            make.top.equalTo(addUserImageView.snp.top)
            make.leading.equalToSuperview().offset(20)
        }
    }
    
    func configEmailTextFieldConstraints() {
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(addUserImageView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(45)
        }
    }
    
    func configPasswordTextFieldConstraints() {
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(15)
            make.leading.equalTo(emailTextField.snp.leading)
            make.trailing.equalTo(emailTextField.snp.trailing)
            make.height.equalTo(emailTextField.snp.height)
        }
    }
    
    func configRegisterButtonConstraints() {
        registerButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(15)
            make.leading.equalTo(emailTextField.snp.leading)
            make.trailing.equalTo(emailTextField.snp.trailing)
            make.height.equalTo(emailTextField.snp.height)
        }
    }
}
