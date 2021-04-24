//
//  RepositoryDetailsPresenter.swift
//  RobustaTask
//
//  Created by Eyad Heikal on 4/24/21.
//

import Foundation

class RepositoryDetailsPresenter: RepositoryDetailsPresenterProtocol {
    weak var view: RepositoryDetailsView?
    var router: RepositoryDetailsRouterProtocol!
    var interactor: RepositoryDetailsInteractorProtocol!

    var repository: Repository!

    // Not Currently Needed But In case I needed to fetch it from BackEnd
    func loadRepository() {
        view?.didLoad(repository: repository)
    }


}
