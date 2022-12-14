//
//  SportTableViewCellScreen.swift
//  MessageApp
//
//  Created by Kaue de Assis Jacyntho on 13/12/22.
//

import UIKit

class SportTableViewCellScreen: UIView {
    
    lazy var collectionView: UICollectionView = {
        let element = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout.init())
        element.translatesAutoresizingMaskIntoConstraints = false
        element.showsHorizontalScrollIndicator = false
        element.backgroundColor = .none
        element.delaysContentTouches = false
        element.register(SportCollectionViewCell.self, forCellWithReuseIdentifier: SportCollectionViewCell.identifier)
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .horizontal
        element.setCollectionViewLayout(layout, animated: false)
        return element
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubView()
        configConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configProtocolsCollectionView(delegate: UICollectionViewDelegate, dataSource: UICollectionViewDataSource) {
        self.collectionView.delegate = delegate
        self.collectionView.dataSource = dataSource
    }
    
    func addSubView() {
        self.addSubview(collectionView)
    }
    
    func configConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    func configConstraintsCollectionView() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    
    
}
