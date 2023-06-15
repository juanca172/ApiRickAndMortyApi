//
//  LocationViewController.swift
//  ApiRickAndMortyNetworking
//
//  Created by Juan Camilo Fonseca Gomez on 5/06/23.
//

import Foundation
import UIKit

class LocationsViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    var viewModel: LocationViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        tableView.reloadData()
        configureViewModel()
    }
    
    func configureTableView() {
        LocationCell.regiterCellInTableView(tableView: tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    private func configureViewModel() {
        viewModel = LocationViewModel()
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

extension LocationsViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.getNumberOfSections() ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.getNumberOfRows(section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LocationCell.reusedId, for: indexPath) as? RMTableViewCellProtocol else {
            return UITableViewCell()
        }
        
        guard let viewModel = viewModel?.getCellViewModel(indexPath: indexPath) else {
            return UITableViewCell()
        }
        
        cell.setUp(viewModel: viewModel)
        return cell
    }
    
    
}
extension LocationsViewController {
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let pos = scrollView.contentOffset.y
            if pos > (tableView.contentSize.height - 100) - scrollView.frame.size.height {
                tableView.reloadData()
                viewModel?.updateData()
            }
           
        }
    
}
