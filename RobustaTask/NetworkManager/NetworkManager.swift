//
//  NetworkManager.swift
//  RobustaTask
//
//  Created by Eyad Heikal on 4/24/21.
//

import Foundation

class NetworkManager {
    private init() {}
    static let shared = NetworkManager()

}

extension NetworkManager {
    func loadRepositories(searchKey key: String, page: Int, count: Int, completion: @escaping (Result<RepoSearchResponse, Error>) -> Void) {
        let url =  URL(string: "https://api.github.com/search/repositories?q=\(key)&per_page=\(count)&page=\(page)")!
        URLSession.shared.dataTask(with: url) { (data, response, error) in

            guard error == nil else {
                return completion(.failure(error!))
            }
            guard let data = data else {
                return completion(.failure(AppError.NoDataReturned))
            }
            guard let repoSearchResponse = try? newJSONDecoder().decode(RepoSearchResponse.self, from: data) else {
                print(String(data: data, encoding: .utf8) ?? .init())
                return completion(.failure(AppError.JSONDecodingFailed))
            }
            completion(.success(repoSearchResponse))
        }
        .resume()
    }

    func loadImageData(at url: URL, success: @escaping (Data) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            success(data)
        }
        .resume()
    }
}
