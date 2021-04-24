//
//  RepositoryDetailsContract.swift
//  RobustaTask
//
//  Created by Eyad Heikal on 4/24/21.
//

import Foundation

protocol RepositoryDetailsView: class {
    func didLoad(repository: Repository)
}

protocol RepositoryDetailsPresenterProtocol {
    func loadRepository()
}

protocol RepositoryDetailsInteractorProtocol {

}

protocol RepositoryDetailsRouterProtocol {

}
