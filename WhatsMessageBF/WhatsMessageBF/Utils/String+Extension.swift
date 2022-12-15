//
//  String+Extension.swift
//  WhatsMessageBF
//
//  Created by Kaue de Assis Jacyntho on 14/12/22.
//

import UIKit

extension String {
    
    func size(Of Font: UIFont) -> CGSize {
        return (self as NSString).size(withAttributes: [NSAttributedString.Key.font: Font])
    }
    
    func heightWithConstrainedWidth(widht: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: widht, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedString.Key.font: font], context: nil)
        return boundingBox.height
    }
    
}
