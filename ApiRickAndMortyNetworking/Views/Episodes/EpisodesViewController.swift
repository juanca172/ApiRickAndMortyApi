//
//  EpisodesViewController.swift
//  ApiRickAndMortyNetworking
//
//  Created by Juan Camilo Fonseca Gomez on 27/06/23.
//

import UIKit

class EpisodesViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var viewModel: EpisodeViewModelProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        tableView.reloadData()
        configureViewModel()

    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        EpisodeCell.regiterCellInTableView(tableView: tableView)
    }
    
    private func configureViewModel() {
        viewModel = EpisodesViewModel()
        viewModel?.start()
        viewModel?.reloadData = { [weak self] in
            guard let weakSelf = self else {
                return
            }
            DispatchQueue.main.async {
                weakSelf.tableView.reloadData()
            }
        }
    }
    
}

extension EpisodesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.getNumberOfRows(section) ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.getNumberOfSectios() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EpisodeCell.reusedId, for: indexPath) as? EpisodeCell else {
            return UITableViewCell()
        }
        
        guard let viewModel = viewModel?.getCellViewModel(index: indexPath) else {
            return UITableViewCell()
        }
        
        cell.setUp(viewModel: viewModel)
        return cell
        
    }
    
    
}

extension EpisodesViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pos = scrollView.contentOffset.y
        if pos > (tableView.contentSize.height - 100) - scrollView.frame.size.height {
            tableView.reloadData()
            viewModel?.updateData()
        }
       
    }
}
