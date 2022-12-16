//
//  LastMessageCollectionViewCell.swift
//  WhatsMessageBF
//
//  Created by Kaue de Assis Jacyntho on 16/12/22.
//

import UIKit

class LastMessageCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "LastMessageCollectionViewCell"
    
    
    lazy var imageView: UIImageView = {
        let element = UIImageView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.contentMode = .scaleAspectFit
        element.clipsToBounds = false
        element.image = UIImage(systemName: "person.badge.plus")
        return element
    }()
    
    lazy var userName: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.text = "Adicionar novo contato"
        element.font = UIFont(name: CustomFont.poppinsMedium, size: 16)
        element.textColor = .darkGray
        element.numberOfLines = 2
        return element
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
}
