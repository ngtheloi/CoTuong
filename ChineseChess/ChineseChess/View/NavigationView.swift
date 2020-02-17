//
//  NavigationView.swift
//  ChineseChess
//
//  Created by Loi Nguyen on 1502//2020.
//  Copyright © 2020 Loi Nguyen. All rights reserved.
//

import UIKit

protocol NavigationViewDelegate {
	func dismissViewController()
}

class NavigationView: UIView {
	static let identifier = "NavigationView"
	var delegate: NavigationViewDelegate!
	@IBOutlet weak var chessView: UIView!
	
	@IBAction func userClickedBackBtn(_ sender: Any) {
		self.delegate.dismissViewController()
	}
}
