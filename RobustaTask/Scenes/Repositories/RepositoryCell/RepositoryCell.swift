//
//  RepositoryCell.swift
//  RobustaTask
//
//  Created by Eyad Heikal on 4/24/21.
//

import UIKit

class RepositoryCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var repositoryNameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    private lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        return dateFormatter
    }()

    override func awakeFromNib() {
        super.awakeFromNib()

        performInitialSetup()
        setupContainerView()
        setupAvatarImageView()
    }
    private func performInitialSetup() {
        selectionStyle = .none
    }
    private func setupContainerView() {
        containerView.layer.cornerRadius = 8
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.lightGray.cgColor
        containerView.layer.masksToBounds = true
    }

    private func setupAvatarImageView() {
        avatarImageView.layer.cornerRadius = 8
        avatarImageView.layer.masksToBounds = true
    }

    func bind(repository: Repository) {
        repositoryNameLabel.text = repository.name
        avatarImageView.image = UIImage(.iconUser)
        ownerNameLabel.text = repository.owner.name
        dateLabel.text = dateFormatter.string(from: repository.creationDate)
    }

    func bind(image: UIImage) {
        avatarImageView.image = image
    }

}
