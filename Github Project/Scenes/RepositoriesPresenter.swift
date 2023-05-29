//
//  RepositoriesPresenter.swift
//  Github Project
//
//  Created by Menaim on 16/01/2022.
//

import Foundation

class RepositoriesPresenter {
    
    //MARK: - Vars
    var repositories: [Repository] = []
    private weak var view: RepositoryView?
    
    //MARK: - Pagination vars
    var repositoriesPerPages = 10
    var limit = 10
    var paginationRepositories: [Repository] = []
    
    //MARK: - Init
    init(_ view: RepositoryView) {
        self.view = view
    }
    
    //MARK: - Public funcs
    func getRepositories() {
        APIService.sharedService.getRepositories { (repositories: [Repository]?, error) in
            
            guard let repositories = repositories else {
                return
            }
            self.repositories = repositories
            self.limit = self.repositories.count
            
            for i in 0..<10 {
                self.paginationRepositories.append(repositories[i])
            }
            DispatchQueue.main.async { [weak self] in
                self?.view?.reloadRepositoriesTableView()
            }
            
        }
    }
    
    func returnRepositoriesCount() -> Int {
        return paginationRepositories.count
    }
    
    func getUsedRepository(at row: Int) -> Repository {
        return paginationRepositories[row]
    }
    
    func willDisplayRepository(at row: Int) {
        if row == paginationRepositories.count - 1 {
            addNewRepositories()
        }
    }
}

//MARK: - Private funcs
extension RepositoriesPresenter {
    private func addNewRepositories() {
        if repositoriesPerPages >= limit {
            return
        }
        else if repositoriesPerPages >= limit - 10 {
            for i in repositoriesPerPages..<limit {
                paginationRepositories.append(repositories[i])
            }
            self.repositoriesPerPages += 10
        }
        else {
            for i in repositoriesPerPages..<repositoriesPerPages + 10 {
                paginationRepositories.append(repositories[i])
            }
            self.repositoriesPerPages += 10
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.view?.reloadRepositoriesTableView()
        }
    }
}
