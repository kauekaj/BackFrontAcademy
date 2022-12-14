//
//  SportCollectionViewCell.swift
//  MessageApp
//
//  Created by Kaue de Assis Jacyntho on 14/12/22.
//

import UIKit

class SportCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "SportCollectionViewCell"
    
    let sportCollectionViewCellScreen: SportCollectionViewCellScreen = SportCollectionViewCellScreen()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubView()
        configConstraints()
    }
    
    public func setupCell(data: Sport) {
        self.sportCollectionViewCellScreen.imageView.image = UIImage(named: data.nameImage)
        self.sportCollectionViewCellScreen.sportName.text = data.name
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubView() {
        sportCollectionViewCellScreen.layer.borderWidth = 6.0
        sportCollectionViewCellScreen.layer.borderColor = UIColor.blue.cgColor
        
        sportCollectionViewCellScreen.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(sportCollectionViewCellScreen)
    }
    
    func configConstraints() {
        NSLayoutConstraint.activate([
            sportCollectionViewCellScreen.topAnchor.constraint(equalTo: self.topAnchor),
            sportCollectionViewCellScreen.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            sportCollectionViewCellScreen.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            sportCollectionViewCellScreen.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    func configConstraintsSportTableViewCellScreen() {
        sportCollectionViewCellScreen.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
