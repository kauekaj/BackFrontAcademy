//
//  SportTableViewCell.swift
//  MessageApp
//
//  Created by Kaue de Assis Jacyntho on 13/12/22.
//

import UIKit

class SportTableViewCell: UITableViewCell {

    static let identifier = "SportTableViewCell"
    
    var data: [Sport] = []
    
    var sportTableViewCellScreen: SportTableViewCellScreen = SportTableViewCellScreen()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubView()
        configConstraints()
        self.sportTableViewCellScreen.configProtocolsCollectionView(delegate: self, dataSource: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubView() {
        sportTableViewCellScreen.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(sportTableViewCellScreen)
    }
    
    func configConstraints() {
        NSLayoutConstraint.activate([
            sportTableViewCellScreen.topAnchor.constraint(equalTo: self.topAnchor),
            sportTableViewCellScreen.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            sportTableViewCellScreen.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            sportTableViewCellScreen.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    func configConstraintsSportTableViewCellScreen() {
        sportTableViewCellScreen.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    public func dataCollection(data: [Sport]) {
        self.data = data
    }
}

extension SportTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: SportCollectionViewCell? = collectionView.dequeueReusableCell(withReuseIdentifier: SportCollectionViewCell.identifier, for: indexPath) as? SportCollectionViewCell
        cell?.setupCell(data: self.data[indexPath.row])
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 140, height: 100)
    }
    
}
