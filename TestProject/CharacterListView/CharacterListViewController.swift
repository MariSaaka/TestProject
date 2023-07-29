//
//  ViewController.swift
//  TestProject
//
//  Created by Mariam Saakashvili on 20/7/23.
//


import UIKit

protocol CharacterListViewProtocol: AnyObject {
    func updateList()
    func disappearSpinnerView()
}

class CharacterListViewController: UIViewController {

    // MARK: - Private Variables
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let searchController = UISearchController(searchResultsController: nil)
    private var presenter: CharacterListPresenter
    private var page = 1
    
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    var isFiltering: Bool {
      return searchController.isActive && !isSearchBarEmpty
    }

    
    // MARK: - Init
    init(presenter: CharacterListPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let router = CharacterListViewRouter(with: self)
        presenter.router = router
        setUpNavigation()
        setUpTableView()
        setUpSearchBar()
        fetchList()
    }

    // MARK: - Private Functions
    private func setUpNavigation() {
        if let navigationController = self.navigationController {
            navigationController.isNavigationBarHidden = false
            navigationItem.title = "Characters"
        }
    }
    
    private func setUpTableView() {
        self.view.addSubview(tableView)
        addConstraints()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(CharacterCell.self, forCellReuseIdentifier: "CharacterCell")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor)
        ])
    }
    
    private func setUpSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func fetchList() {
        presenter.viewDidLoad()
    }
}


// MARK: - UITableView
extension CharacterListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return presenter.numberOfFilteredCharacters()
        }
        return presenter.numberOfCharacters()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell") as! CharacterCell
        let characterModel: CharacterCell.CellModel
        if isFiltering {
            characterModel = presenter.getFilteredCharacterModel(at: indexPath.row)
        }else {
            characterModel = presenter.getCharacterInfo(at: indexPath.row)
        }
        cell.configure(with: characterModel)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.showCharacter(at: indexPath.row, is: isFiltering)
    }
    
    
    private func createSpinnerFooter() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        return footerView
    }
}

// MARK: - UIScrollViewDelegate
extension CharacterListViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (tableView.contentSize.height - 100 - scrollView.frame.size.height) {
            self.tableView.tableFooterView = createSpinnerFooter()
            presenter.fetchMoreCharacters()
        }
    }
}

// MARK: - UISearchBarDelegate
extension CharacterListViewController: UISearchBarDelegate,  UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        presenter.filterContentForSearchText(searchText: searchBar.text!)
    }
}

// MARK: - CharacterListViewProtocol
extension CharacterListViewController: CharacterListViewProtocol {
    
    func updateList() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func disappearSpinnerView() {
        DispatchQueue.main.async {
            self.tableView.tableFooterView = nil
        }
    }
}
