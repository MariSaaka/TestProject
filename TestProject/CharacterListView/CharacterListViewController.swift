//
//  ViewController.swift
//  TestProject
//
//  Created by Mariam Saakashvili on 20/7/23.
//


import UIKit

protocol CharacterListViewProtocol: AnyObject {
    func updateList()
    func updateImage(at index: IndexPath)
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
        searchBar.delegate = self
        let frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 50)
        searchBar = UISearchBar(frame: frame)
        tableView.tableHeaderView = searchBar
    }
    
    private func fetchList() {
        let url = URL(string: "https://rickandmortyapi.com/api/character")!
        presenter.viewDidLoad(with: url)
    }
}


// MARK: - UITableView
extension CharacterListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfCharacters()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell") as! CharacterCell
        let characterModel = presenter.getCharacterInfo(at: indexPath)
        cell.configure(with: characterModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}


// MARK: - UISearchBarDelegate
extension CharacterListViewController: UISearchBarDelegate {
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let url = URL(string: "https://rickandmortyapi.com/api/character/?name=rick")!
        presenter.viewDidLoad(with: url)
        searchBar.resignFirstResponder()
    }
}

// MARK: - CharacterListViewProtocol
extension CharacterListViewController: CharacterListViewProtocol {
    func updateImage(at index: IndexPath) {
        self.tableView.reloadRows(at: [index], with: .automatic)
    }
    
    func updateList() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}






