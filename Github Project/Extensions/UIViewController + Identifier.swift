//
//  UIViewController + Identifier.swift
//  Github Project
//
//  Created by Menaim on 09/02/2022.
//

import UIKit

extension UIViewController {
    static var identifier: String {
        String(describing: Self.self)
    }
}
