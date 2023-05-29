//
//  RepositoriesViewController.swift
//  Github Project
//
//  Created by Menaim on 03/01/2022.
//

import UIKit

protocol RepositoryView: AnyObject {
    func reloadRepositoriesTableView()
}

class RepositoriesViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var repositoriesTableView: UITableView!
    
    //MARK: - Vars
    private var presenter: RepositoriesPresenter!
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = RepositoriesPresenter(self)
        configureTableView()
        presenter.getRepositories()
        self.title = "Repositories"
    }
    
    //MARK: - Configure TableView
    private func configureTableView() {
        repositoriesTableView.dataSource = self
        repositoriesTableView.delegate = self
        repositoriesTableView.register(UINib(nibName: String(describing: RepositoryCell.self), bundle: nil), forCellReuseIdentifier: RepositoryCell.identifier)
    }
    
    
}

//MARK: - TableView DataSource
extension RepositoriesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.returnRepositoriesCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = repositoriesTableView.dequeueReusableCell(withIdentifier: RepositoryCell.identifier, for: indexPath) as? RepositoryCell else {return UITableViewCell()}
        
        cell.configureCell(with: presenter.getUsedRepository(at: indexPath.row))
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        presenter.willDisplayRepository(at: indexPath.row)
    }
    
    
}

//MARK: - View Extension
extension RepositoriesViewController: RepositoryView {
    func reloadRepositoriesTableView() {
        DispatchQueue.main.async { [weak self] in
            self?.repositoriesTableView.reloadData()
        }
    }
    
    
}
