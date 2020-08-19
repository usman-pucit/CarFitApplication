//
//  UITableView.swift
//  CarFitApplication
//
//  Created by Usman on 07/08/2020.
//  Copyright © 2020 usman-pucit All rights reserved.
//

import UIKit

// MARK: - Extension for UITableView

extension UITableView {
   
    // MARK: - Function register nib
    
    func registerNib<T: UITableViewCell>(_: T.Type){
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.nibName, bundle: bundle)
        
        register(nib, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    // MARK: - Function dequeue cell

    func dequeue<T: UITableViewCell>(_: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: String(describing: T.self),
                                             for: indexPath) as? T
        else { fatalError("Could not dequeue cell with type \(T.self)") }
        return cell
    }
}
