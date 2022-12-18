//
//  MessageDetailCollectionViewCell.swift
//  WhatsMessageBF
//
//  Created by Kaue de Assis Jacyntho on 16/12/22.
//

import UIKit

class MessageDetailCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "MessageDetailCollectionViewCell"
    
    
    lazy var imageView: UIImageView = {
        let element = UIImageView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.contentMode = .scaleAspectFit
        element.clipsToBounds = true
        element.layer.cornerRadius = 26
        element.image = UIImage(named: "imagem-perfil")
        return element
    }()
    
    lazy var userName: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.numberOfLines = 2
        return element
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    func setupView() {
        self.addSubview(imageView)
        self.addSubview(userName)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 55),
            imageView.heightAnchor.constraint(equalToConstant: 55),
            
            userName.leadingAnchor.constraint(equalTo: self.imageView.trailingAnchor, constant: 15),
            userName.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            userName.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViewContact(contact: Contact) {
        self.setUserName(userName: contact.name ?? "")
    }
    
    func setupViewConversation(conversation: Conversation) {
        self.setUserNameAttributedtext(conversation)
    }
    
    func setUserName(userName: String) {
        let attributedtext = NSMutableAttributedString(string: userName, attributes: [NSAttributedString.Key.font: UIFont(name: CustomFont.poppinsMedium, size: 16) ?? UIFont(), NSMutableAttributedString.Key.foregroundColor: UIColor.darkGray])
        self.userName.attributedText = attributedtext
        
//        self.userName.text = userName
    }
    
    func setUserNameAttributedtext(_ conversation: Conversation) {
        let attributedtext = NSMutableAttributedString(string: "\(conversation.userName ?? "")", attributes: [NSAttributedString.Key.font: UIFont(name: CustomFont.poppinsMedium, size: 16) ?? UIFont(), NSMutableAttributedString.Key.foregroundColor: UIColor.darkGray])
        
        attributedtext.append(NSAttributedString(string: "\n\(conversation.lastMessage ?? "")", attributes: [NSAttributedString.Key.font: UIFont(name: CustomFont.poppinsMedium, size: 14) ?? UIFont(), NSMutableAttributedString.Key.foregroundColor: UIColor.lightGray]))
        
        self.userName.attributedText = attributedtext
    }
    
   
}
