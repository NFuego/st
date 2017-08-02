//
//  AppointStoreMonthRouter.swift
//  Project: momoCustomer
//
//  Module: AppointStoreMonth
//
//  By ssstand 2017/3/12
//  MomoDidi 2017年
//

// MARK: Imports

import UIKit

import SwiftyVIPER

// MARK: Protocols

/// Should be conformed to by the `AppointStoreMonthRouter` and referenced by `AppointStoreMonthPresenter`
protocol AppointStoreMonthPresenterRouterProtocol: PresenterRouterProtocol {

}


// MARK: -

/// The Router for the AppointStoreMonth module
final class AppointStoreMonthRouter {

	// MARK: - Variables

	weak var viewController: UIViewController?
}

// MARK: - Router Protocol

extension AppointStoreMonthRouter: RouterProtocol {

}

// MARK: AppointStoreMonth Presenter to Router Protocol

extension AppointStoreMonthRouter: AppointStoreMonthPresenterRouterProtocol {

}
