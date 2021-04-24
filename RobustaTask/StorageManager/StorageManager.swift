//
//  StorageManager.swift
//  RobustaTask
//
//  Created by Eyad Heikal on 4/24/21.
//

import Foundation

class StorageManager {
    private var storedRepositories: [Repository] = []

    func cache(repositories: [Repository]) {
        storedRepositories = repositories
    }

    func fetchRepositories() -> [Repository] {
        return storedRepositories
    }
}
