//
//  Repository.swift
//  RobustaTask
//
//  Created by Eyad Heikal on 4/24/21.
//

import Foundation

struct Repository {
    let id: Int
    let name: String
    let creationDate: Date
    let owner: RepositoryOwner
    let numberOfForks: Int
    let numberOfStars: Int
    let language: String
    let licenseName: String

    static let dummy: Self = {
        return .init(
            id: 12345,
            name: "Dummy",
            creationDate: Date(),
            owner: .dummy,
            numberOfForks: 5,
            numberOfStars: 44,
            language: "Swift",
            licenseName: "MIT License"
        )
    }()

}
