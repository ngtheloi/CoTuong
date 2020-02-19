//
//  MainViewController.swift
//  ChineseChess
//
//  Created by Loi Nguyen on 1502//2020.
//  Copyright © 2020 Loi Nguyen. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
	// Outlet
	@IBOutlet weak var startBtn: UIButton!
	@IBOutlet weak var settingBtn: UIButton!
	@IBOutlet weak var historyBtn: UIButton!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.loadUI()
	}

	func loadUI() {
		let corner = startBtn.frame.size.height / 2
		startBtn.layer.cornerRadius = corner
		settingBtn.layer.cornerRadius = corner
		historyBtn.layer.cornerRadius = corner
		
		let color = UIColor.red.cgColor
		startBtn.layer.borderColor = color
		settingBtn.layer.borderColor = color
		historyBtn.layer.borderColor = color
		
		startBtn.layer.borderWidth = 1
		settingBtn.layer.borderWidth = 1
		historyBtn.layer.borderWidth = 1
	}
	
	@IBAction func userClickedStartBtn(_ sender: Any) {
		let gameVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: GameViewController.identifier)
		self.present(gameVC, animated: true, completion: nil)
	}
	
	@IBAction func userClickedSettingView(_ sender: Any) {
		let settingView = Bundle.main.loadNibNamed("AssistantView", owner: self, options: nil)?.first as! AssistantView
		settingView.loadText(.Setting)
		self.view.addSubview(settingView)
	}
	
	@IBAction func userClickedHistoryBtn(_ sender: Any) {
	}
}

