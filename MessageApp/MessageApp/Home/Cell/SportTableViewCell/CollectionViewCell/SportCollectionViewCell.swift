//
//  SportCollectionViewCell.swift
//  MessageApp
//
//  Created by Kaue de Assis Jacyntho on 14/12/22.
//

import UIKit

class SportCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "SportCollectionViewCell"
    
    let sportCollectionViewCell: SportCollectionViewCellScreen = SportCollectionViewCellScreen()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubView()
        configConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubView() {
        sportCollectionViewCell.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(sportCollectionViewCell)
    }
    
    func configConstraints() {
        NSLayoutConstraint.activate([
            sportCollectionViewCell.topAnchor.constraint(equalTo: self.topAnchor),
            sportCollectionViewCell.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            sportCollectionViewCell.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            sportCollectionViewCell.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    func configConstraintsSportTableViewCellScreen() {
        sportCollectionViewCell.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
