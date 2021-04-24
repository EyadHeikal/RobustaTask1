//
//  RepositoryDetailsContract.swift
//  RobustaTask
//
//  Created by Eyad Heikal on 4/24/21.
//

import Foundation

protocol RepositoryDetailsView: class {
    func didLoad(repository: Repository)
    func didLoad(imageData: Data)
}

protocol RepositoryDetailsPresenterProtocol {
    func loadRepository()
}

protocol RepositoryDetailsInteractorProtocol {
    func loadImageData(at urlString: String, success: @escaping (Data) -> Void)

}

protocol RepositoryDetailsRouterProtocol {

}
