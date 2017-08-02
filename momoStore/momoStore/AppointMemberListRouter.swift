//
//  AppointMemberListRouter.swift
//  Project: momoStore
//
//  Module: AppointMemberList
//
//  By ssstand 2017/3/11
//  MomoDidi 2017年
//

// MARK: Imports

import UIKit

import SwiftyVIPER

// MARK: Protocols

/// Should be conformed to by the `AppointMemberListRouter` and referenced by `AppointMemberListPresenter`
protocol AppointMemberListPresenterRouterProtocol: PresenterRouterProtocol {

}


// MARK: -

/// The Router for the AppointMemberList module
final class AppointMemberListRouter {

	// MARK: - Variables

	weak var viewController: UIViewController?
}

// MARK: - Router Protocol

extension AppointMemberListRouter: RouterProtocol {

}

// MARK: AppointMemberList Presenter to Router Protocol

extension AppointMemberListRouter: AppointMemberListPresenterRouterProtocol {

}
