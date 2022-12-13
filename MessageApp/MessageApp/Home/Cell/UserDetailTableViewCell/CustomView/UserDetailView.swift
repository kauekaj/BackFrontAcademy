//
//  UserDetailView.swift
//  MessageApp
//
//  Created by Kaue de Assis Jacyntho on 13/12/22.
//

import UIKit

class UserDetailView: UIView {

    lazy var userImageView: UIImageView = {
        let element = UIImageView()
        element.translatesAutoresizingMaskIntoConstraints = false
//        element.image = UIImage(named: "logo")
        element.contentMode = .scaleAspectFit
        return element
    }()
    
    lazy var nameLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.textColor = .black
        return element
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func addSubView() {
        self.addSubview(userImageView)
        self.addSubview(nameLabel)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            userImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            userImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            userImageView.heightAnchor.constraint(equalToConstant: 80),
            userImageView.widthAnchor.constraint(equalToConstant: 80),

            nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: self.userImageView.trailingAnchor, constant: 20),
        ])
    }
    
    func configureUserImageViewConstraints() {
        self.userImageView.snp.makeConstraints { make in
            make.centerY.leading.equalToSuperview()
            make.height.width.equalTo(80)
        }
    }
    
    func configureNameLabelConstraints() {
        self.nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(self.userImageView.snp.trailing).offset(20)
        }
    }
  
}
