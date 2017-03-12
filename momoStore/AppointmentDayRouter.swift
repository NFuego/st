//
//  AppointmentDayRouter.swift
//  Project: momoStore
//
//  Module: AppointmentDay
//
//  By ssstand 2017/3/12
//  MomoDidi 2017年
//

// MARK: Imports

import UIKit

import SwiftyVIPER

// MARK: Protocols

/// Should be conformed to by the `AppointmentDayRouter` and referenced by `AppointmentDayPresenter`
protocol AppointmentDayPresenterRouterProtocol: PresenterRouterProtocol {

}


// MARK: -

/// The Router for the AppointmentDay module
final class AppointmentDayRouter {

	// MARK: - Variables

	weak var viewController: UIViewController?
}

// MARK: - Router Protocol

extension AppointmentDayRouter: RouterProtocol {

}

// MARK: AppointmentDay Presenter to Router Protocol

extension AppointmentDayRouter: AppointmentDayPresenterRouterProtocol {

}
