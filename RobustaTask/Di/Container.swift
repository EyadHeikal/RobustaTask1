//
//  Container.swift
//  RobustaTask
//
//  Created by Eyad Heikal on 4/24/21.
//

import Swinject

public let container = Container(defaultObjectScope: .container) { container in

    container.register(NetworkManager.self) { resolver in
        return NetworkManager.shared
    }

    container.register(UINavigationController.self) { resolver in
        return UINavigationController()
    }
    .initCompleted { (resolver, navigationController) in
        navigationController.setViewControllers([resolver.resolve(RepositoriesViewController.self)!], animated: true)
    }


    container.register(RepositoriesViewController.self) { resolver in
        let name = String(describing: RepositoriesViewController.self)
        let bundle = Bundle(for: RepositoriesViewController.self)
        return RepositoriesViewController(nibName: name, bundle: bundle)
    }
    .initCompleted { (resolver, viewController) in
        viewController.presenter = resolver.resolve(RepositoriesPresenter.self)!
    }

    container.register(RepositoriesPresenter.self) { resolver in
        let presenter = RepositoriesPresenter()
        presenter.interactor = resolver.resolve(RepositoriesInteractor.self)!
        presenter.router = resolver.resolve(RepositoriesRouter.self)!
        return presenter
    }
    .initCompleted { (resolver, presenter) in
        presenter.view = resolver.resolve(RepositoriesViewController.self)!
    }

    container.register(RepositoriesInteractor.self) { resolver in
        let interactor = RepositoriesInteractor()
        interactor.networkManager = resolver.resolve(NetworkManager.self)!
        return interactor
    }

    container.register(RepositoriesRouter.self) { resolver in
        let router = RepositoriesRouter()
        return router
    }
    .initCompleted { (resolver, router) in
        router.navigationController = resolver.resolve(UINavigationController.self)!
    }
}
