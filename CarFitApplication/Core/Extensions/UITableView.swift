//
//  UITableView.swift
//  CarFitApplication
//
//  Created by Muhammad Usman on 07/08/2020.
//  Copyright © 2020 usman. All rights reserved.
//

import UIKit

// MARK: - Extension for UITableView

extension UITableView {
    // MARK: - Function register cell generically
    
    func register<T: UITableViewCell>(_: T.Type) where T: ResuableViews {
        self.register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    // MARK: - Function register nib
    
    func registerNib<T: UITableViewCell>(_: T.Type) where T: ResuableViews, T: NibLoadableView {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.nibName, bundle: bundle)
        
        register(nib, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    // MARK: - Function deque cell generically
    
    func dequeue<T: UITableViewCell>(_: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: String(describing: T.self),
                                             for: indexPath) as? T
        else { fatalError("Could not deque cell with type \(T.self)") }
        return cell
    }
}
