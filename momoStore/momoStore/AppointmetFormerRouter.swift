//
//  AppointmetFormerRouter.swift
//  Project: testt
//
//  Module: AppointmetFormer
//
//  By zcon 2017/3/9
//  test 2017年
//

// MARK: Imports

import UIKit

import SwiftyVIPER

// MARK: Protocols

/// Should be conformed to by the `AppointmetFormerRouter` and referenced by `AppointmetFormerPresenter`
protocol AppointmetFormerPresenterRouterProtocol: PresenterRouterProtocol {

}

// MARK: -

/// The Router for the AppointmetFormer module
final class AppointmetFormerRouter {

	// MARK: - Variables

	weak var viewController: UIViewController?
}

// MARK: - Router Protocol

extension AppointmetFormerRouter: RouterProtocol {

}

// MARK: AppointmetFormer Presenter to Router Protocol

extension AppointmetFormerRouter: AppointmetFormerPresenterRouterProtocol {

}
