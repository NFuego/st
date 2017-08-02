//
//  PlanInteractor.swift
//  Project: momoCustomer
//
//  Module: Plan
//
//  By ssstand 2017/3/12
//  MomoDidi 2017年
//

// MARK: Imports

import Foundation

import SwiftyVIPER


// MARK: Protocols

/// Should be conformed to by the `PlanInteractor` and referenced by `PlanPresenter`
protocol PlanPresenterInteractorProtocol {
	/// Requests the title for the presenter
	func requestTitle()
}


// MARK: -

/// The Interactor for the Plan module
struct PlanInteractor {

	// MARK: - Variables

	weak var presenter: PlanInteractorPresenterProtocol?
}

// MARK: - Plan Presenter to Interactor Protocol

extension PlanInteractor: PlanPresenterInteractorProtocol {

	func requestTitle() {
		presenter?.set(title: "Plan")
	}
}
