//
//  UIView+Utils.swift
//  CrossDK-demo UIKit
//
//  Created by Adikteev on 30/08/2021.
//

import Foundation
import UIKit

// MARK: - UIView extention

extension UIView {
    /// Drops a shadow to a view.
    func dropShadow() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.shadowRadius = 3.0
        layer.shadowColor = #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1)
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        layer.shadowOpacity = 0.4
        layer.masksToBounds = false
    }
}
