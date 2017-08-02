//
//  MemberModule.swift
//  Project: momoStore
//
//  Module: Member
//
//  MomoDidi 2016年
//

// MARK: Imports

import UIKit

import SwiftyVIPER


// MARK: -

/// Used to initialize the Member VIPER module
final class MemberModule {

	// MARK: - Variables

	private(set) lazy var interactor: MemberInteractor = {
		return MemberInteractor()
	}()

	private(set) lazy var router: MemberRouter = {
		return MemberRouter()
	}()

	private(set) lazy var presenter: MemberPresenter = {
		return MemberPresenter(router: self.router, interactor: self.interactor)
	}()

	private(set) lazy var view: MemberViewController = {
        let memberVC = MemberViewController(presenter: self.presenter)
        memberVC.tabBarItem.icon(from: .MaterialIcon, code: "perm.contact.calendar",imageSize:CGSize(width: 20, height: 20),ofSize:20)
        memberVC.tabBarItem.title = "會員"
        
		return memberVC
	}()

	init() {
		presenter.view = view
		router.viewController = view
		interactor.presenter = presenter
	}
}

// MARK: - Module Protocol

extension MemberModule: ModuleProtocol {
	var viewController: UIViewController {return view}
}
