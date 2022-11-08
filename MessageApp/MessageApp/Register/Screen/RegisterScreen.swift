//
//  RegisterScreen.swift
//  MessageApp
//
//  Created by Kaue de Assis Jacyntho on 08/11/22.
//

import UIKit

class RegisterScreen: UIView {
    
    lazy var backButton: UIButton = {
        let element = UIButton()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.setImage(UIImage(named: "back"), for: .normal)
        //        element.addTarget(self, action: #selector(tappedRegisterButton), for: .touchUpInside)
        return element
    }()
    
    lazy var addUserImageView: UIImageView = {
        let element = UIImageView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.image = UIImage(named: "usuario")
        element.contentMode = .scaleAspectFit
        return element
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configBackground()
        configSuperView()
        setupConstraints()
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
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            addUserImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            addUserImageView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            addUserImageView.widthAnchor.constraint(equalToConstant: 150),
            addUserImageView.heightAnchor.constraint(equalToConstant: 150),
            
            backButton.topAnchor.constraint(equalTo: addUserImageView.topAnchor),
            backButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
        ])
    }
}
