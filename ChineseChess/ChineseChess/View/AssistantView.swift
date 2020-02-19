//
//  AssistantView.swift
//  ChineseChess
//
//  Created by Loi Nguyen on 2002//2020.
//  Copyright © 2020 Loi Nguyen. All rights reserved.
//

import UIKit

class AssistantView: UIView {
	@IBOutlet weak var assistantView_Bottom: NSLayoutConstraint!
	@IBOutlet weak var superContentView: UIView!
	@IBOutlet weak var titleLbl: UILabel!
	@IBOutlet weak var settingContentView: UIView!
	@IBOutlet weak var timeLeftTextField: UITextField!
	@IBOutlet weak var pausesLeftTextField: UITextField!
	@IBOutlet weak var pauseTimeLeftTextField: UITextField!
	@IBOutlet weak var cancelBtn: UIButton!
	@IBOutlet weak var saveBtn: UIButton!
	
	var change = false
	var activeColor = UIColor(red:0.30, green:0.85, blue:0.39, alpha:1.0)
	var inActiveColor = UIColor(red:0.74, green:0.74, blue:0.74, alpha:1.0)
	var currentTimeLeft = String(MyAppDelegate.setting.timeLeft)
	var currentPausesLeft = String(MyAppDelegate.setting.pausesLeft)
	var currentPauseTimeLeft = String(MyAppDelegate.setting.pauseTimeLeft)
	
	override func awakeFromNib() {
		super.awakeFromNib()
		self.configTextField()
		self.addTapGesture()
		self.loadUI()
		self.loadButtonsState()
	}
	
	func configTextField() {
		timeLeftTextField.keyboardType = .numberPad
		pausesLeftTextField.keyboardType = .numberPad
		pauseTimeLeftTextField.keyboardType = .numberPad
		
		timeLeftTextField.delegate = self
		pausesLeftTextField.delegate = self
		pauseTimeLeftTextField.delegate = self
		
		NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
	}
	
	func addTapGesture() {
		let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapView))
		self.addGestureRecognizer(tapRecognizer)
	}
	
	@objc func tapView() {
		self.endEditing(true)
	}
	
	@objc func keyboardWillShow(_ notification: NSNotification) {
		if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight = keyboardSize.height
			assistantView_Bottom.constant = keyboardHeight
			UIView.animate(withDuration: 0.3) {
				self.layoutIfNeeded()
			}
        }
	}
	
	@objc func keyboardWillHide(_ notification: NSNotification) {
		if self.assistantView_Bottom.constant != 0 {
			self.assistantView_Bottom.constant = 0
		}
		UIView.animate(withDuration: 0.3) {
			self.layoutIfNeeded()
		}
	}
	
	func loadText(_ style: AssistantStyle) {
		if style == .Setting {
			settingContentView.isHidden = false
			titleLbl.text = "SETTING"
			timeLeftTextField.text = currentTimeLeft
			pausesLeftTextField.text = currentPausesLeft
			pauseTimeLeftTextField.text = currentPauseTimeLeft
		}
	}
	
	func loadUI() {
		let viewCorner = superContentView.bounds.size.height / 20
		superContentView.layer.cornerRadius = viewCorner
		
		superContentView.layer.borderWidth = 1
		superContentView.layer.borderColor = UIColor.white.cgColor
		
		let buttonCorner = cancelBtn.bounds.size.height / 2
		cancelBtn.layer.cornerRadius = buttonCorner
		saveBtn.layer.cornerRadius = buttonCorner
		
		cancelBtn.layer.borderWidth = 1
		saveBtn.layer.borderWidth = 1
		
		cancelBtn.layer.borderColor = UIColor.white.cgColor
		saveBtn.layer.borderColor = UIColor.white.cgColor
	}
	
	func loadButtonsState() {
		saveBtn.isUserInteractionEnabled = change
		saveBtn.backgroundColor = change ? activeColor : inActiveColor
	}
	
	func removeThisView() {
		self.removeFromSuperview()
		NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
		NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
	}
	
	func reloadGameSetting() {
		UserDefaults.standard.set(timeLeftTextField.text, forKey: "timeLeft")
		UserDefaults.standard.set(pausesLeftTextField.text, forKey: "pausesLeft")
		UserDefaults.standard.set(pauseTimeLeftTextField.text, forKey: "pauseTimeLeft")
		UserDefaults.standard.synchronize()
		MyAppDelegate.setting = GameSetting(Int(timeLeftTextField!.text!)!, Int(pausesLeftTextField!.text!)!, Int(pauseTimeLeftTextField!.text!)!)
	}
	
	@IBAction func userClickedCancelBtn(_ sender: Any) {
		self.removeThisView()
	}
	
	@IBAction func userClickedSaveBtn(_ sender: Any) {
		self.removeThisView()
		self.reloadGameSetting()
	}
}

extension AssistantView: UITextFieldDelegate {
	func textFieldDidChangeSelection(_ textField: UITextField) {
		if timeLeftTextField.text != currentTimeLeft || pausesLeftTextField.text != currentPausesLeft || pauseTimeLeftTextField.text != currentPauseTimeLeft {
			change = true
			self.loadButtonsState()
		}
	}
}
