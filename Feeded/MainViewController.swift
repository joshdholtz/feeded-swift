//
//  MainViewController.swift
//  Feeded
//
//  Created by Josh Holtz on 6/19/15.
//  Copyright (c) 2015 Josh Holtz. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
	
	var viewModel: MainViewModel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		title = "- Feeded -"
		viewModel = MainViewModel(onAction: onAction, navigationItem: navigationItem)
		
		// Creating presenter
		let presenter = MainPresenter(view: view, viewModel: viewModel)
		presenter.setup()
	}
	
	private func onAction(viewModel: SetupViewModel, action: SetupViewModel.Action) {
		switch action {
		case .SetupFinished:
			self.dismissViewControllerAnimated(true, completion: nil)
		}
	}
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		viewModel.showOptions()
		viewModel.updateBadgeCount()
	}
	
	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)
	
		if AppDelegate.shared().getName() == nil {
			showSetup()
		}
	}
	
	// MARK: Actions
	
	@objc private func nothing() { }
	@objc private func logout() { viewModel.logout() }
	@objc private func reset() { viewModel.reset() }
	@objc private func showLogoutConfirmation() { viewModel.showLogoutConfirmation() }
	@objc private func showOptions() { viewModel.showOptions() }
	@objc private func showResetConfirmation() { viewModel.showResetConfirmation() }
	
	// MARK: Private
	
	private func onAction(viewModel: MainViewModel, action: MainViewModel.Action) {
		switch action {
		case .Logout:
			self.showSetup()
		case .Reset:
			viewModel.showOptions()
			
		case .ShowOptions: ()
			navigationItem.setLeftBarButtonItem(btnLogout, animated: true)
			navigationItem.setRightBarButtonItem(btnReset, animated: true)
		case .ShowLogoutConfirmation:
			navigationItem.setLeftBarButtonItem(btnYesLogout, animated: true)
			navigationItem.setRightBarButtonItem(btnNo, animated: true)
		case .ShowResetConfirmation:
			navigationItem.setLeftBarButtonItem(btnYesReset, animated: true)
			navigationItem.setRightBarButtonItem(btnNo, animated: true)
		}
	}
	
	private func showSetup() {
		let vc = SetupViewController()
		presentViewController(vc, animated: true, completion: nil)
	}
	
}

// MARK: UITableViewDataSource

extension MainViewController: UITableViewDataSource {
	
	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 0
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		return UITableViewCell()
	}
	
}

// MARK: UITableViewDelegate

extension MainViewController: UITableViewDelegate {
	
	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		
	}
	
}

// MARK: Navigation bar buttons
// Buttons are in this extension because they looked ugly at the top of the view controller

extension MainViewController {
	var btnLogout: UIBarButtonItem {
		let image = IonIcons.imageWithIcon(ion_log_out, iconColor: Colors.clouds, iconSize: 30, imageSize: CGSize(width: 30, height: 30))
		return UIBarButtonItem(image: image, style: UIBarButtonItemStyle.Plain, target: self, action: Selector("showLogoutConfirmation"))
	}
	var btnReset: UIBarButtonItem {
		let image = IonIcons.imageWithIcon(ion_nuclear, iconColor: Colors.clouds, iconSize: 30, imageSize: CGSize(width: 30, height: 30))
		return UIBarButtonItem(image: image, style: UIBarButtonItemStyle.Plain, target: self, action: Selector("showResetConfirmation"))
	}
	var btnYesLogout: UIBarButtonItem {
		let image = IonIcons.imageWithIcon(ion_android_checkmark_circle, iconColor: Colors.clouds, iconSize: 30, imageSize: CGSize(width: 30, height: 30))
		return UIBarButtonItem(image: image, style: UIBarButtonItemStyle.Plain, target: self, action: Selector("logout"))
	}
	var btnYesReset: UIBarButtonItem {
		let image = IonIcons.imageWithIcon(ion_android_checkmark_circle, iconColor: Colors.clouds, iconSize: 30, imageSize: CGSize(width: 30, height: 30))
		return UIBarButtonItem(image: image, style: UIBarButtonItemStyle.Plain, target: self, action: Selector("reset"))
	}
	var btnNo: UIBarButtonItem {
		let image = IonIcons.imageWithIcon(ion_android_close, iconColor: Colors.clouds, iconSize: 30, imageSize: CGSize(width: 30, height: 30))
		return UIBarButtonItem(image: image, style: UIBarButtonItemStyle.Plain, target: self, action: Selector("showOptions"))
	}
}