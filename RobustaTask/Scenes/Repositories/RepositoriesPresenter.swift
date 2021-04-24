//
//  RepositoriesPresenter.swift
//  RobustaTask
//
//  Created by Eyad Heikal on 4/24/21.
//

import Foundation

class RepositoriesPresenter: RepositoriesPresenterProtocol {
    weak var view: RepositoriesView?
    var router: RepositoriesRouterProtocol!
    var interactor: RepositoriesInteractorProtocol!

    private var repositories = [Repository]()
    private var isPaginating = false
    private var pageNumber = 1
    private let count = 10
    private var timer: Timer?
    private var searchKey: String = .init()
    private let maxPageCount = 100 //API fetches only 100 pages


    func loadRepositories(searchKey: String) {
        self.searchKey = searchKey.trimmingCharacters(in: .whitespacesAndNewlines)
        timer?.invalidate()
        timer = .scheduledTimer(withTimeInterval: 0.700, repeats: false) { [weak self] timer in
            guard let self = self else { return }
            self.loadRepositories(searchKey: self.searchKey, page: 1, count: self.count)
        }
    }

    private func loadRepositories(searchKey: String, page: Int, count: Int) {
        interactor.loadRepositories(searchKey: searchKey, page: page, count: count) { [weak self]  result in
            guard let self = self else { return }
            switch result {
                case let .success(repositories):
                    DispatchQueue.main.async { [weak self] in
                        self?.repositories = repositories
                        self?.isPaginating = false
                        self?.pageNumber = page
                        self?.view?.didLoadRepositoriesForTheFirstTime()
                    }
                case .failure:
                    DispatchQueue.main.async { [weak self] in
                        self?.isPaginating = false
                    }
            }
        }
    }

    func loadMoreRepositoriesIfNeeded(for indexPaths: [IndexPath]) {
        guard count <= maxPageCount else { return }
        guard indexPaths.contains(where: isPaginationIndexPath) && !isPaginating else { return }
        isPaginating.toggle()
        let pageNumber = self.pageNumber + 1

        interactor.loadRepositories(searchKey: searchKey,
                                    page: pageNumber,
                                    count: count) { [weak self]  result in
            guard let self = self else { return }
            switch result {
                case let .success(repositories):
                    //Update repositories on Main Queue to avoid any race condition
                    DispatchQueue.main.async { [weak self] in
                        self?.repositories.append(contentsOf: repositories)
                        self?.isPaginating = false
                        self?.pageNumber = pageNumber
                        self?.view?.didLoadMoreRepositories()
                    }
                case let .failure(error):
                    print(error)
                    DispatchQueue.main.async { [weak self] in
                        self?.isPaginating = false
                    }
            }
        }
    }
    private func isPaginationIndexPath(indexPath: IndexPath) -> Bool {
        return indexPath.row >= repositories.count - 5
    }

    func loadImageData(at indexPath: IndexPath) {
        interactor.loadImageData(at: repositories[indexPath.row].owner.avatarURLString) { imageData in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.view?.didLoad(imageData: imageData, at: indexPath)
            }
        }
    }

    func getNumberOfItems() -> Int {
        guard repositories.isEmpty else {
            return repositories.count
        }
        return 0
    }

    func getRepository(for indexPath: IndexPath) -> Repository {
        return repositories[indexPath.row]
    }

    func didSelectRow(at indexPath: IndexPath) {
        guard repositories.count > 0 else { return }
        router.navigateToRepositoryDetailsView(with: repositories[indexPath.row])
    }
}
