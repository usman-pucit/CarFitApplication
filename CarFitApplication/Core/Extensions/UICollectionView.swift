//
//  UICollectionView.swift
//  CarFitApplication
//
//  Created by Muhammad Usman on 11/08/2020.
//  Copyright © 2020 usman. All rights reserved.
//

import UIKit

// MARK: - Extension UICollectionView

extension UICollectionView {
    // MARK: - Function register cell
    
    func register<T: UICollectionViewCell>(_: T.Type) where T: ResuableViews {
        register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
    
    // MARK: - Function register nib
    
    func registerNib<T: UICollectionViewCell>(_: T.Type) where T: ResuableViews, T: NibLoadableView {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.nibName, bundle: bundle)
        
        register(nib, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
    
    // MARK: - Function dequeue cell
    
    func dequeueCell<T: UICollectionViewCell>(_: T.Type, for indexPath: IndexPath) -> T where T: ResuableViews {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        
        return cell
    }
}
