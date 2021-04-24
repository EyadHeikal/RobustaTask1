//
//  UIImage+Extensions.swift
//  RobustaTask
//
//  Created by Eyad Heikal on 4/24/21.
//

import UIKit

extension UIImage {
    enum Image: String {
        case iconUser
    }

    convenience init(_ image: Image) {
        self.init(named: image.rawValue)!
    }
}
