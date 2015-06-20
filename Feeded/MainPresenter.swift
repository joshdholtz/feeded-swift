//
//  MainPresenter.swift
//  Feeded
//
//  Created by Josh Holtz on 6/19/15.
//  Copyright (c) 2015 Josh Holtz. All rights reserved.
//

import Foundation
import Few

struct MainPresenter {
	
	let view: UIView
	let viewModel: MainViewModel
	
	func setup() {
		let component = Component<MainViewModel>(initialState: viewModel, render: MainPresenter.render)
		component.addToView(view)
	}
	
	private static func render(component: Component<MainViewModel>, viewModel: MainViewModel) -> Element {
		return View(backgroundColor: Colors.midnightBlue)
			.justification(.Center)
			.childAlignment(.Center)
			.direction(.Column)
			.children([
				
//				// Label
//				Label("Welcome to Feeded!",
//					textColor: UIColor.whiteColor(),
//					font: UIFont.boldSystemFontOfSize(26))
//					.margin(Edges(left: 0, right: 0, bottom: 10, top: 0)),
//				
//				// Input
//				{ () -> Input in
//					let i = Input(
//						textColor: UIColor.whiteColor(),
//						placeholder: "Enter your pet's name",
//						textChanged: { text in
//							component.updateState { _ in
//								var updatedViewModel = viewModel
//								updatedViewModel.name = text
//								return updatedViewModel
//							}
//						}
//					)
//					i.width(100)
//					return i
//					}(),
//				
//				// Button
//				View(backgroundColor: Colors.pomegranate)
//					.margin(Edges(uniform: 10))
//					.children([
//						Button(title: "Get started!", action: {
//							viewModel.finishSetup()
//						})
//							.width(100)
//							.padding(Edges(uniform: 10))
//						])
				])
	}
	
}