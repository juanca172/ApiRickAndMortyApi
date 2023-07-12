//
//  FavoritesViewController.swift
//  ApiRickAndMortyNetworking
//
//  Created by Juan Camilo Fonseca Gomez on 10/07/23.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private var viewModel: FavoritesViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        configureTableView()
        configureViewModel()
        // Do any additional setup after loading the view.
    }
    
    private func configureTableView() {
        FavoritesCell.regiterCellInTableView(tableView: tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func configureViewModel() {
        viewModel = FavoritesViewModel()
        viewModel?.start()
        viewModel?.reloadData = { [weak self] in
            DispatchQueue.main.sync {
                self?.tableView.reloadData()
            }
        }
    }
    
}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.getNumberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesCell.reusedId, for: indexPath) as? FavoritesCell else {
            return UITableViewCell()
        }
        guard let viewModel = viewModel?.cellViewModel(indexPath: indexPath) else {
            return UITableViewCell()
        }
        
        cell.setUp(viewModel: viewModel)
        
        return cell
    }
    
    
}
