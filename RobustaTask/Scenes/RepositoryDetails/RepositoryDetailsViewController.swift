//
//  RepositoryDetailsViewController.swift
//  RobustaTask
//
//  Created by Eyad Heikal on 4/24/21.
//

import UIKit

class RepositoryDetailsViewController: UIViewController {

    @IBOutlet weak var repositoryImageView: UIImageView!
    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet weak var forksCountLabel: UILabel!
    @IBOutlet weak var dateCreatedLabel: UILabel!
    @IBOutlet weak var starsCountLabel: UILabel!
    @IBOutlet weak var licenseLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!

    var presenter: RepositoryDetailsPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.loadRepository()
    }


}

extension RepositoryDetailsViewController: RepositoryDetailsView {
    func didLoad(repository: Repository) {
        navigationItem.title = repository.name
        repositoryImageView.image = UIImage(.iconUser)
        ownerNameLabel.text = repository.owner.name
        forksCountLabel.text = repository.numberOfForks.description
        dateCreatedLabel.text = repository.creationDate.description
        starsCountLabel.text = repository.numberOfStars.description
        licenseLabel.text = repository.licenseName
        languageLabel.text = repository.language
    }
}

