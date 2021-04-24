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

        interactor.loadImageData(at: repository.owner.avatarURLString) { imageData in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.view?.didLoad(imageData: imageData)
            }
        }
    }


}
