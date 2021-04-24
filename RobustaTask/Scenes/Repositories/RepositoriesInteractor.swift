//
//  RepositoriesInteractor.swift
//  RobustaTask
//
//  Created by Eyad Heikal on 4/24/21.
//

import Foundation

class RepositoriesInteractor: RepositoriesInteractorProtocol {

    var networkManager: NetworkManager!

    func loadImageData(at urlString: String, success: @escaping (Data) -> Void) {
        guard let url = URL(string: urlString) else { return }
        networkManager.loadImageData(at: url, success: success)
    }

    func loadRepositories(
        searchKey key: String,
        page: Int,
        count: Int,
        completion: @escaping (Result<[Repository], Error>) -> Void) {
        guard key.count > 1 else { return }

        networkManager.loadRepositories(searchKey: key, page: page, count: count) { result in

            func convertRepoSearchResponseItemToRepository(_ item: Item) -> Repository {
                let owner = RepositoryOwner(
                    id: item.owner.id,
                    name: item.owner.login,
                    avatarURLString: item.owner.avatarURL
                )
                return Repository(
                    id: item.id,
                    name: item.name,
                    creationDate: item.createdAt,
                    owner: owner,
                    numberOfForks: item.forks,
                    numberOfStars: item.stargazersCount,
                    language: item.language ?? "N/A",
                    licenseName: item.license?.name ?? "N/A"
                )
            }

            let result = result.map { $0.items.map (convertRepoSearchResponseItemToRepository) }
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }


}
