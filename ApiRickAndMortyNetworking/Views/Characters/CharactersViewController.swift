//
//  ViewController.swift
//  ApiRickAndMortyNetworking
//
//  Created by Juan Camilo Fonseca Gomez on 28/06/22.
//

import UIKit
import CoreData

class CharactersViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    private var viewModel: CharacterViewModelProtocol?
    var canRecharge: Bool = true
    var managedObjectContext: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        tableView.reloadData()
        configureViewModel()
        callit()
    }
    
    func configureTableView() {
        CharacterCell.regiterCellInTableView(tableView: tableView)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func configureViewModel() {
        viewModel = CharactersViewModel()
        viewModel?.start()
        viewModel?.reloadData = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    let applicationDocumentsDirectory: URL = {
      let paths = FileManager.default.urls(
        for: .documentDirectory,
        in: .userDomainMask)
      return paths[0]
    }()
    func callit() {
        print(applicationDocumentsDirectory)
    }
    
}

extension CharactersViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.getNumberOfSections() ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.getNumberOfRows(section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterCell.reusedId, for: indexPath) as? RMTableViewCellProtocol else {
            return UITableViewCell()
        }
         
        guard let viewModel = viewModel?.getCellViewModel(indexPath: indexPath) else {
            return UITableViewCell()
        }
        
        cell.setUp(viewModel: viewModel)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "showDetail", sender: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return indexPath
    }
    
}

extension CharactersViewController: UITableViewDelegate {
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let pos = scrollView.contentOffset.y
            if pos > (tableView.contentSize.height - 100) - scrollView.frame.size.height {
                if canRecharge {
                    viewModel?.updateData()
                    tableView.reloadData()
                }
            }
           
        }
    
}
extension CharactersViewController {
    //MARK: -Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            guard let controller = segue.destination as? DetailCharacterViewController else {
                return
            }
            controller.modalPresentationStyle = .overFullScreen
            let indexpath = sender as! IndexPath
            controller.idToSearch = viewModel?.getId(indexPath: indexpath)
            //Enviamos coredata
            controller.managedObjectContext = managedObjectContext
        }
    }
    
}

extension CharactersViewController: UISearchBarDelegate {
    //MARK: -Delegate from search bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            self.canRecharge = false
            viewModel?.updateFilterData(search: searchText)
            tableView.reloadData()
        } else {
            self.canRecharge = true
            viewModel?.vaciarFiltro()
            tableView.reloadData()
        }
    }
}

