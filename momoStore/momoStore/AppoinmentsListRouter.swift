//
//  AppoinmentsListRouter.swift
//  Project: momoStore
//
//  Module: AppoinmentsList
//
//  By zcon 2017/3/9
//  MomoDidi 2017年
//

// MARK: Imports

import UIKit

import SwiftyVIPER

// MARK: Protocols

/// Should be conformed to by the `AppoinmentsListRouter` and referenced by `AppoinmentsListPresenter`
protocol AppoinmentsListPresenterRouterProtocol: PresenterRouterProtocol {

}

// MARK: -

/// The Router for the AppoinmentsList module
final class AppoinmentsListRouter {

	// MARK: - Variables

	weak var viewController: UIViewController?
}

// MARK: - Router Protocol

extension AppoinmentsListRouter: RouterProtocol {

}

// MARK: AppoinmentsList Presenter to Router Protocol

extension AppoinmentsListRouter: AppoinmentsListPresenterRouterProtocol {

}
