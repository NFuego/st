//
//  MemberProfileRouter.swift
//  Project: momoStore
//
//  Module: MemberProfile
//
//  MomoDidi 2016年
//

// MARK: Imports

import UIKit

import SwiftyVIPER

// MARK: Protocols

/// Should be conformed to by the `MemberProfileRouter` and referenced by `MemberProfilePresenter`
protocol MemberProfilePresenterRouterProtocol: PresenterRouterProtocol {

}


// MARK: -

/// The Router for the MemberProfile module
final class MemberProfileRouter {

	// MARK: - Variables

	weak var viewController: UIViewController?
}

// MARK: - Router Protocol

extension MemberProfileRouter: RouterProtocol {

}

// MARK: MemberProfile Presenter to Router Protocol

extension MemberProfileRouter: MemberProfilePresenterRouterProtocol {

}
