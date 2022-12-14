//
//  SportCollectionViewCellScreen.swift
//  MessageApp
//
//  Created by Kaue de Assis Jacyntho on 14/12/22.
//

import UIKit

class SportCollectionViewCellScreen: UIView {

    lazy var imageView: UIImageView = {
        let element = UIImageView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.contentMode = .scaleAspectFit
        return element
    }()
    
    lazy var sportName: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.textAlignment = .center
        element.textColor = .darkGray
        return element
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addView()
        configConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addView() {
        self.addSubview(imageView)
        self.addSubview(sportName)
    }

    func configConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor,  constant: 10),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            imageView.bottomAnchor.constraint(equalTo: self.sportName.topAnchor, constant: -10),
            
            sportName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            sportName.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            sportName.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            sportName.heightAnchor.constraint(equalToConstant: 20)

        ])
    }

}
