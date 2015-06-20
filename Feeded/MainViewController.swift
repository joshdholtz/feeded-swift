//
//  MainViewController.swift
//  Feeded
//
//  Created by Josh Holtz on 6/19/15.
//  Copyright (c) 2015 Josh Holtz. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

	var btnLogout: UIBarButtonItem {
		return UIBarButtonItem(title: "Logout", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("showConfirmation"))
	}
	var btnReset: UIBarButtonItem {
		return UIBarButtonItem(title: "Reset", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("reset"))
	}
	var btnYes: UIBarButtonItem {
		return UIBarButtonItem(title: "Yes", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("logout"))
	}
	var btnNo: UIBarButtonItem {
		return UIBarButtonItem(title: "No", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("showLogout"))
	}
	
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
		viewModel.showLogout()
	}
	
	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)
	
		if AppDelegate.shared().getName() == nil {
			showSetup()
		}
	}
	
	// MARK: Actions
	
	@objc private func logout() { viewModel.logout() }
	@objc private func reset() { viewModel.reset() }
	@objc private func showConfirmation() { viewModel.showConfirmation() }
	@objc private func showLogout() { viewModel.showLogout() }
	
	// MARK: Private
	
	private func onAction(viewModel: MainViewModel, action: MainViewModel.Action) {
		switch action {
		case .Logout:
			self.showSetup()
		case .Reset:
			()
			
		case .ShowLogout: ()
			navigationItem.setLeftBarButtonItem(btnLogout, animated: true)
			navigationItem.setRightBarButtonItem(btnReset, animated: true)
		case .ShowLogoutConfirmation:
			navigationItem.setLeftBarButtonItem(btnYes, animated: true)
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