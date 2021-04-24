//
//  RepositoryDetailsInteractor.swift
//  RobustaTask
//
//  Created by Eyad Heikal on 4/24/21.
//

import Foundation

class RepositoryDetailsInteractor: RepositoryDetailsInteractorProtocol {

    var networkManager: NetworkManager!

    
    func loadImageData(at urlString: String, success: @escaping (Data) -> Void) {
        guard let url = URL(string: urlString) else { return }
        networkManager.loadImageData(at: url, success: success)
    }
    


}
