//
//  NavigationView.swift
//  WhatsMessageBF
//
//  Created by Kaue de Assis Jacyntho on 15/12/22.
//

import UIKit

enum TypeConversationOrContact {
    case conversation
    case contact
}

protocol NavigationViewProtocol: AnyObject {
    func typeScreenMessage(type: TypeConversationOrContact)
}

class NavigationView: UIView {
    
    weak private var delegate: NavigationViewProtocol?
    
    func delegate(delegate: NavigationViewProtocol?) {
        self.delegate = delegate
    }
    
    lazy var navigationBackgroundView: UIView = {
        let element = UIView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.backgroundColor = .white
        element.layer.cornerRadius = 35
        element.layer.maskedCorners = [.layerMaxXMaxYCorner]
        element.layer.shadowColor = UIColor(white: 0, alpha: 0.02).cgColor
        element.layer.shadowOffset = CGSize(width: 0, height: 5)
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
        element.font = UIFont(name: CustomFont.poppinsMedium, size: 16)
        element.textColor = .lightGray
        return element
    }()
    
    lazy var searchButton: UIButton = {
        let element = UIButton()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.setImage(UIImage(named: "search"), for: .normal)
        return element
    }()
    
    let stackView: UIStackView = {
        let element = UIStackView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.distribution = .fillEqually
        element.axis = .horizontal
        element.spacing = 10
        return element
    }()
    
    lazy var conversationButton: UIButton = {
        let element = UIButton()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.setImage(UIImage(systemName: "message")?.withRenderingMode(.alwaysTemplate), for: .normal)
        element.tintColor = .systemPink
        element.addTarget(self, action: #selector(tappedConversationButton), for: .touchUpInside)
        return element
    }()
    
    lazy var contactButton: UIButton = {
        let element = UIButton()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.setImage(UIImage(named: "group")?.withRenderingMode(.alwaysTemplate), for: .normal)
        element.tintColor = .black
        element.addTarget(self, action: #selector(tappedContactButton), for: .touchUpInside)
        return element
    }()
    
    @objc
    func tappedConversationButton() {
        self.conversationButton.tintColor = .systemPink
        self.contactButton.tintColor = .black
        self.delegate?.typeScreenMessage(type: .conversation)
    }
    
    @objc
    func tappedContactButton() {
        self.conversationButton.tintColor = .black
        self.contactButton.tintColor = .systemPink
        self.delegate?.typeScreenMessage(type: .contact)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.addSubview(navigationBackgroundView)
        self.navigationBackgroundView.addSubview(navigationBar)
        self.navigationBar.addSubview(searchBar)
        self.navigationBar.addSubview(stackView)
        self.searchBar.addSubview(searchLabel)
        self.searchBar.addSubview(searchButton)
        self.stackView.addArrangedSubview(conversationButton)
        self.stackView.addArrangedSubview(contactButton)

        
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            navigationBackgroundView.topAnchor.constraint(equalTo: self.topAnchor),
            navigationBackgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            navigationBackgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            navigationBackgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            navigationBar.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            navigationBar.bottomAnchor.constraint(equalTo: self.bottomAnchor),

            searchBar.leadingAnchor.constraint(equalTo: self.navigationBar.leadingAnchor, constant: 30),
            searchBar.centerYAnchor.constraint(equalTo: self.navigationBar.centerYAnchor),
            searchBar.trailingAnchor.constraint(equalTo: self.stackView.leadingAnchor, constant: -20),
            searchBar.heightAnchor.constraint(equalToConstant: 55),
            
            stackView.trailingAnchor.constraint(equalTo: self.navigationBar.trailingAnchor, constant: -30),
            stackView.centerYAnchor.constraint(equalTo: self.navigationBar.centerYAnchor),
            stackView.widthAnchor.constraint(equalToConstant: 100),
            stackView.heightAnchor.constraint(equalToConstant: 30),

            searchLabel.leadingAnchor.constraint(equalTo: self.searchBar.leadingAnchor, constant: 25),
            searchLabel.centerYAnchor.constraint(equalTo: self.searchBar.centerYAnchor),

            searchButton.trailingAnchor.constraint(equalTo: self.searchBar.trailingAnchor, constant: -20),
            searchButton.centerYAnchor.constraint(equalTo: self.searchBar.centerYAnchor),
            searchButton.widthAnchor.constraint(equalToConstant: 20),
            searchButton.heightAnchor.constraint(equalToConstant: 20),

        ])
    }
    
}

