//
//  RepositoriesContract.swift
//  RobustaTask
//
//  Created by Eyad Heikal on 4/24/21.
//

import Foundation

protocol RepositoriesView: class {
    func didLoadRepositoriesForTheFirstTime()
    func didLoadMoreRepositories()
    func didLoad(imageData: Data, at indexPath: IndexPath)
}

protocol RepositoriesPresenterProtocol {
    func loadRepositories(searchKey: String)
    func loadMoreRepositoriesIfNeeded(for indexPaths: [IndexPath])
    func getNumberOfItems() -> Int
    func getRepository(for indexPath: IndexPath) -> Repository
    func loadImageData(at indexPath: IndexPath)
    func didSelectRow(at indexPath: IndexPath)
}

protocol RepositoriesInteractorProtocol {
    func loadImageData(at urlString: String, success: @escaping (Data) -> Void)
    func loadRepositories(searchKey key: String, page: Int, count: Int, completion: @escaping (Result<[Repository], Error>) -> Void)
}

protocol RepositoriesRouterProtocol {
    func navigateToRepositoryDetailsView(with repository: Repository)
}
