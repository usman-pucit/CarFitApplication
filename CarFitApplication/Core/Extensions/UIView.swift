//
//  UIView.swift
//  CarFitApplication
//
//  Created by Usman on 13/08/2020.
//  Copyright © 2020 usman-pucit All rights reserved.
//

import UIKit

extension UIView {
    class func initFromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: self), owner: nil, options: nil)?[0] as! T
    }
}
