//
//  AppointmentCreateFormRouter.swift
//  Project: momoStore
//
//  Module: AppointmentCreateForm
//
//  By ssstand 2017/3/12
//  MomoDidi 2017年
//

// MARK: Imports

import UIKit

import SwiftyVIPER

// MARK: Protocols

/// Should be conformed to by the `AppointmentCreateFormRouter` and referenced by `AppointmentCreateFormPresenter`
protocol AppointmentCreateFormPresenterRouterProtocol: PresenterRouterProtocol {

}


// MARK: -

/// The Router for the AppointmentCreateForm module
final class AppointmentCreateFormRouter {

	// MARK: - Variables

	weak var viewController: UIViewController?
}

// MARK: - Router Protocol

extension AppointmentCreateFormRouter: RouterProtocol {

}

// MARK: AppointmentCreateForm Presenter to Router Protocol

extension AppointmentCreateFormRouter: AppointmentCreateFormPresenterRouterProtocol {

}
