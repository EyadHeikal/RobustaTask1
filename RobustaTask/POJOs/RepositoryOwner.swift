//
//  RepositoryOwner.swift
//  RobustaTask
//
//  Created by Eyad Heikal on 4/24/21.
//

import Foundation

struct RepositoryOwner: Codable {
    let id: Int
    let name: String
    let avatarURLString: String

    static let dummy: Self = {
        .init(id: 12345, name:"John Doe", avatarURLString: "https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50")
    }()
}
