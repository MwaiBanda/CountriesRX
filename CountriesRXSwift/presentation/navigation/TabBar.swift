//
//  TabBar.swift
//  LoginRXSwift
//
//  Created by Mwai Banda on 5/31/22.
//

import UIKit

class TabBar: UITabBar {
  
    override func draw(_ rect: CGRect) {
       super.draw(rect)
        barTintColor = .systemGray5
        tintColor = .black
        backgroundColor = .systemGray5
    }

}
