//
//  RepositoriesViewController.swift
//  RobustaTask
//
//  Created by Eyad Heikal on 4/24/21.
//

import UIKit

class RepositoriesViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    var presenter: RepositoriesPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupTableView()
        setupSearchBar()
    }

    private func setupView() {
        navigationItem.title = "Search"
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.prefetchDataSource = self
        tableView.separatorStyle = .none
        tableView.allowsSelection = true

        tableView.register(cellType: RepositoryCell.self, EmptyCell.self)
    }

    private func setupSearchBar() {
        searchBar.searchTextField.becomeFirstResponder()
        searchBar.delegate = self
    }

}


// MARK: RepositoriesView
extension RepositoriesViewController: RepositoriesView {
    func didLoadRepositoriesForTheFirstTime() {
        tableView.reloadSections([0], with: .automatic)
        tableView.scrollToRow(at: .init(row: 0, section: 0), at: .top, animated: false)
    }
    func didLoadMoreRepositories() {
        tableView.reloadData()
    }

    func didLoad(imageData: Data, at indexPath: IndexPath) {
        guard let image = UIImage(data: imageData),
              let cell = tableView.cellForRow(at: indexPath) as? RepositoryCell else { return }
        cell.bind(image: image)
    }
}

// MARK: UITableViewDelegate & DataSource
extension RepositoriesViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRepositories = presenter.getNumberOfItems()
        guard numberOfRepositories > 0 else { return 1 }
        return numberOfRepositories
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let numberOfRepositories = presenter.getNumberOfItems()
        guard numberOfRepositories > 0 else { return createEmptyCell(for: indexPath) }
        return createRepositoryCell(for: indexPath)
    }

    private func createRepositoryCell(for indexPath: IndexPath) -> RepositoryCell {
        let cell = tableView.dequeueReusableCell(withType: RepositoryCell.self, for: indexPath)
        cell.bind(repository: presenter.getRepository(for: indexPath))
        presenter.loadImageData(at: indexPath)
        return cell
    }

    private func createEmptyCell(for indexPath: IndexPath) -> EmptyCell {
        let cell = tableView.dequeueReusableCell(withType: EmptyCell.self, for: indexPath)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectRow(at: indexPath)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        searchBar.searchTextField.resignFirstResponder()
    }

}

// MARK: UITableViewDataSourcePrefetching
extension RepositoriesViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        presenter.loadMoreRepositoriesIfNeeded(for: indexPaths)
    }

}

// MARK: UISearchBarDelegate
extension RepositoriesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.loadRepositories(searchKey: searchText)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.searchTextField.resignFirstResponder()
    }
}

