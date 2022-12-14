//
//  HomeViewController.swift
//  MessageApp
//
//  Created by Kaue de Assis Jacyntho on 05/12/22.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    
    var homeScreen: HomeScreen?
    var dataUser: [DataUser] = [DataUser(name: "Kaue", nameImage: "menino1"),
                            DataUser(name: "Caio", nameImage: "menino2"),
                            DataUser(name: "Laura", nameImage: "menina1"),
                            ]
    
    var dataSport: [Sport] = [Sport(name: "Corrida", nameImage: "corrida"),
                              Sport(name: "Ciclismo", nameImage: "ciclismo"),
                              Sport(name: "Natacao", nameImage: "natacao"),
                              Sport(name: "Yoga", nameImage: "yoga"),
                            ]
    
    override func loadView() {
        self.homeScreen = HomeScreen()
        self.view = homeScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.homeScreen?.configTableViewProtocols(delegate: self, dataSource: self)
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.dataUser.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 3 {
            let cell: SportTableViewCell? = tableView.dequeueReusableCell(withIdentifier: SportTableViewCell.identifier, for: indexPath) as? SportTableViewCell
            cell?.dataCollection(data: self.dataSport)
            return cell ?? UITableViewCell()
        }
        
        let cell: UserDetailTableViewCell? = tableView.dequeueReusableCell(withIdentifier: UserDetailTableViewCell.identifier, for: indexPath) as? UserDetailTableViewCell
        
        cell?.setupCell(data: self.dataUser[indexPath.row])
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
