//
//  Coordinator.swift
//  SwiftArquiteturas
//
//  Created by Kaue de Assis Jacyntho on 27/12/22.
//

import Foundation
import UIKit

protocol Coordinator {
    
    var navigationController: UINavigationController { get }
   
    func start()
    
    init(navigationController: UINavigationController)
}

