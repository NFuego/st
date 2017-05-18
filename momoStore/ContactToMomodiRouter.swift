//
//  ContactToMomodiRouter.swift
//  Project: momoStore
//
//  Module: ContactToMomodi
//
//  By zcon 2017/5/18
//  MomoDidi 2017年
//

// MARK: Imports

import UIKit

import SwiftyVIPER

// MARK: Protocols

/// Should be conformed to by the `ContactToMomodiRouter` and referenced by `ContactToMomodiPresenter`
protocol ContactToMomodiPresenterRouterProtocol: PresenterRouterProtocol {

}

// MARK: -

/// The Router for the ContactToMomodi module
final class ContactToMomodiRouter {

	// MARK: - Variables

	weak var viewController: UIViewController?
}

// MARK: - Router Protocol

extension ContactToMomodiRouter: RouterProtocol {

}

// MARK: ContactToMomodi Presenter to Router Protocol

extension ContactToMomodiRouter: ContactToMomodiPresenterRouterProtocol {

}
