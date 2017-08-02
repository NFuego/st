//
//  ContactsRouter.swift
//  Project: momoCustomer
//
//  Module: Contacts
//
//  By ssstand 2017/3/12
//  MomoDidi 2017年
//

// MARK: Imports

import UIKit

import SwiftyVIPER

// MARK: Protocols

/// Should be conformed to by the `ContactsRouter` and referenced by `ContactsPresenter`
protocol ContactsPresenterRouterProtocol: PresenterRouterProtocol {

}


// MARK: -

/// The Router for the Contacts module
final class ContactsRouter {

	// MARK: - Variables

	weak var viewController: UIViewController?
}

// MARK: - Router Protocol

extension ContactsRouter: RouterProtocol {

}

// MARK: Contacts Presenter to Router Protocol

extension ContactsRouter: ContactsPresenterRouterProtocol {

}
