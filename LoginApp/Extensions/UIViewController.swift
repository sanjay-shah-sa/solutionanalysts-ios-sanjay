//
//  UIViewController.swift
//  LoginApp
//
//  Created by Sanjay Shah on 03/01/2021.
//  Copyright © 2021 Solution Analysts. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

extension UIViewController: NVActivityIndicatorViewable {
    /// Show LoadingView When API is called
    func showLoading(message: String = "",
                     color: UIColor = UIColor.red,
                     type: NVActivityIndicatorType = .circleStrokeSpin) {
        let size = CGSize(width: 40, height:40)
        startAnimating(size, message: nil, type: type, color: color, backgroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.4))
    }

    /// Hide LoadingView
    func hideLoading() {
        stopAnimating()
    }
}
