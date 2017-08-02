//
//  MemberRouter.swift
//  Project: momoStore
//
//  Module: Member
//
//  MomoDidi 2016年
//

// MARK: Imports

import UIKit

import SwiftyVIPER

// MARK: Protocols

/// Should be conformed to by the `MemberRouter` and referenced by `MemberPresenter`
protocol MemberPresenterRouterProtocol: PresenterRouterProtocol {

}


// MARK: -

/// The Router for the Member module
final class MemberRouter {

	// MARK: - Variables

	weak var viewController: UIViewController?
}

// MARK: - Router Protocol

extension MemberRouter: RouterProtocol {

}

// MARK: Member Presenter to Router Protocol

extension MemberRouter: MemberPresenterRouterProtocol {

}
