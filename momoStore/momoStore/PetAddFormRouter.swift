//
//  PetAddFormRouter.swift
//  Project: momoCustomer
//
//  Module: PetAddForm
//
//  By zcon 2017/5/18
//  MomoDidi 2017年
//

// MARK: Imports

import UIKit

import SwiftyVIPER

// MARK: Protocols

/// Should be conformed to by the `PetAddFormRouter` and referenced by `PetAddFormPresenter`
protocol PetAddFormPresenterRouterProtocol: PresenterRouterProtocol {

}

// MARK: -

/// The Router for the PetAddForm module
final class PetAddFormRouter {

	// MARK: - Variables

	weak var viewController: UIViewController?
}

// MARK: - Router Protocol

extension PetAddFormRouter: RouterProtocol {

}

// MARK: PetAddForm Presenter to Router Protocol

extension PetAddFormRouter: PetAddFormPresenterRouterProtocol {

}
