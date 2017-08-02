//
//  ContactsModule.swift
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


// MARK: -

/// Used to initialize the Contacts VIPER module
final class ContactsModule {

	// MARK: - Variables

	private(set) lazy var interactor: ContactsInteractor = {
		return ContactsInteractor()
	}()

	private(set) lazy var router: ContactsRouter = {
		return ContactsRouter()
	}()

	private(set) lazy var presenter: ContactsPresenter = {
		return ContactsPresenter(router: self.router, interactor: self.interactor)
	}()

	private(set) lazy var view: ContactsViewController = {
//		return ContactsViewController(presenter: self.presenter)
        let monthVC = ContactsViewController(presenter: self.presenter)
        monthVC.tabBarItem.icon(from: .MaterialIcon, code: "perm.contact.calendar" ,imageSize:CGSize(width: 20, height: 20),ofSize:20)
        monthVC.tabBarItem.title = "聯絡人"
        return monthVC
	}()

	init() {
		presenter.view = view
		router.viewController = view
		interactor.presenter = presenter
	}
}

// MARK: - Module Protocol

extension ContactsModule: ModuleProtocol {
	var viewController: UIViewController {return view}
}
