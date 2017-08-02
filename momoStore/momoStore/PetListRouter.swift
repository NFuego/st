//
//  PetListRouter.swift
//  Project: momoCustomer
//
//  Module: PetList
//
//  By zcon 2017/5/17
//  MomoDidi 2017年
//

// MARK: Imports

import UIKit

import SwiftyVIPER

// MARK: Protocols

/// Should be conformed to by the `PetListRouter` and referenced by `PetListPresenter`
protocol PetListPresenterRouterProtocol: PresenterRouterProtocol {

}

// MARK: -

/// The Router for the PetList module
final class PetListRouter {

	// MARK: - Variables

	weak var viewController: UIViewController?
}

// MARK: - Router Protocol

extension PetListRouter: RouterProtocol {

}

// MARK: PetList Presenter to Router Protocol

extension PetListRouter: PetListPresenterRouterProtocol {

}
