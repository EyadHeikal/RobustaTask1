//
//  RepositoriesRouter.swift
//  RobustaTask
//
//  Created by Eyad Heikal on 4/24/21.
//

import UIKit

class RepositoriesRouter: RepositoriesRouterProtocol {

    var navigationController: UINavigationController!

    func navigateToRepositoryDetailsView(with repository: Repository) {
        let viewController = container.resolve(RepositoryDetailsViewController.self)!
        let presenter = container.resolve(RepositoryDetailsPresenter.self, argument: repository)!
        viewController.presenter = presenter
        navigationController.pushViewController(viewController, animated: true)
    }
}
