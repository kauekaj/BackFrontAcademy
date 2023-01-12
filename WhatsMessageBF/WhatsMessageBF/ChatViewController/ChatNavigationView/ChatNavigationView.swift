//
//  ChatNavigationView.swift
//  WhatsMessageBF
//
//  Created by Kaue de Assis Jacyntho on 18/12/22.
//

import UIKit

class ChatNavigationView: UIView {

    var controller: ChatViewController? {
        didSet{
            self.backButton.addTarget(controller, action: #selector(ChatViewController.tappedBackButton), for: .touchUpInside)
        }
    }
    
    lazy var navigationBackgroundView: UIView = {
        let element = UIView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.backgroundColor = .white
        element.layer.cornerRadius = 35
        element.layer.maskedCorners = [.layerMaxXMaxYCorner]
        element.layer.shadowColor = UIColor(white: 0, alpha: 0.05).cgColor
        element.layer.shadowOffset = CGSize(width: 0, height: 10)
        element.layer.shadowOpacity = 1
        element.layer.shadowRadius = 10
        return element
    }()
    
    lazy var navigationBar: UIView = {
        let element = UIView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.backgroundColor = .clear
        return element
    }()
    
    lazy var searchBar: UIView = {
        let element = UIView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.backgroundColor = CustomColor.appLight
        element.clipsToBounds = true
        element.layer.cornerRadius = 20
        return element
    }()
    
    lazy var searchLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.text = "Digite aqui"
        element.font = UIFont.systemFont(ofSize: 14) //UIFont(name: CustomFont.poppinsMedium, size: 26)
        element.textColor = .lightGray
        return element
    }()
    
    lazy var searchButton: UIButton = {
        let element = UIButton()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.setImage(UIImage(named: "search"), for: .normal)
        return element
    }()
    
    lazy var backButton:UIButton = {
    let element = UIButton()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.setImage(UIImage(named: "back"), for: .normal)
    return element
    }()
    
    lazy var customImage:UIImageView = {
        let element = UIImageView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.contentMode = .scaleAspectFill
        element.clipsToBounds = true
        element.layer.cornerRadius = 26
        element.image = UIImage(named: "imagem-perfil")
        return element
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addElemented()
        self.configContraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addElemented(){
        self.addSubview(self.navigationBackgroundView)
        self.navigationBackgroundView.addSubview(self.navigationBar)
        self.navigationBar.addSubview(self.backButton)
        self.navigationBar.addSubview(self.customImage)
        self.navigationBar.addSubview(self.searchBar)
        self.searchBar.addSubview(self.searchLabel)
        self.searchBar.addSubview(self.searchButton)
    }
    
    
    private func configContraints(){
    
        NSLayoutConstraint.activate([
        
            self.navigationBackgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.navigationBackgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.navigationBackgroundView.topAnchor.constraint(equalTo: self.topAnchor),
            self.navigationBackgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            self.navigationBar.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.navigationBar.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.navigationBar.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.navigationBar.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            self.backButton.leadingAnchor.constraint(equalTo: self.navigationBar.leadingAnchor, constant: 30),
            self.backButton.centerYAnchor.constraint(equalTo: self.navigationBar.centerYAnchor),
            self.backButton.heightAnchor.constraint(equalToConstant: 30),
            self.backButton.widthAnchor.constraint(equalToConstant: 30),
            
            self.customImage.leadingAnchor.constraint(equalTo: self.backButton.trailingAnchor, constant: 20),
            self.customImage.heightAnchor.constraint(equalToConstant: 55),
            self.customImage.widthAnchor.constraint(equalToConstant: 55),
            self.customImage.centerYAnchor.constraint(equalTo: self.navigationBar.centerYAnchor),
            
            self.searchBar.leadingAnchor.constraint(equalTo: self.customImage.trailingAnchor, constant: 20),
            self.searchBar.centerYAnchor.constraint(equalTo: self.navigationBar.centerYAnchor),
            self.searchBar.trailingAnchor.constraint(equalTo: self.navigationBar.trailingAnchor, constant: -20),
            self.searchBar.heightAnchor.constraint(equalToConstant: 55),
            
            self.searchLabel.leadingAnchor.constraint(equalTo: self.searchBar.leadingAnchor,constant: 25),
            self.searchLabel.centerYAnchor.constraint(equalTo: self.searchBar.centerYAnchor),
            
            self.searchButton.trailingAnchor.constraint(equalTo: self.searchBar.trailingAnchor,constant: -20),
            self.searchButton.centerYAnchor.constraint(equalTo: self.searchBar.centerYAnchor),
            self.searchButton.heightAnchor.constraint(equalToConstant: 20),
            self.searchButton.widthAnchor.constraint(equalToConstant: 20)
        ])
        
    }
    
}
