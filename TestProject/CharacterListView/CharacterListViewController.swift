//
//  ViewController.swift
//  TestProject
//
//  Created by Mariam Saakashvili on 20/7/23.
//


import UIKit

protocol CharacterListViewProtocol: AnyObject {
    func updateList()
}

class CharacterListViewController: UIViewController {

    // MARK: - Private Variables
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        return searchBar
    }()
    
    private var presenter: CharacterListPresenter
    
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
        setUpNavigation()
        setUpTableView()
        setUpSearchBar()
        presenter.viewDidLoad()
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
        searchBar.delegate = self
        let frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 50)
        searchBar = UISearchBar(frame: frame)
        tableView.tableHeaderView = searchBar
    }
}


// MARK: - UITableView
extension CharacterListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfCharacters()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell") as! CharacterCell
        let character = presenter.getCharacterInfo(at: indexPath)
        let characterImage = presenter.getCharacterImage(at: indexPath)
        cell.configure(with: .init(name: character.name, status: character.gender, image: characterImage))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = CharacterDetailViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


// MARK: - UISearchBarDelegate
extension CharacterListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

// MARK: - CharacterListViewProtocol
extension CharacterListViewController: CharacterListViewProtocol {
    func updateList() {
        self.tableView.reloadData()
    }
}






