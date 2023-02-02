//
//  ViewController.swift
//  ApiRickAndMortyNetworking
//
//  Created by Juan Camilo Fonseca Gomez on 28/06/22.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    var charactersSection : [[RMCharacter]] = []
    var page = 1
    let dataManager = RMDefaultCharacterDataManager()
    var isPaginating = false
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        loadData(page: page)
    }
    
    func configureTableView() {
        
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        tableView.register(nib , forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    func loadData(page: Int) {
        if isPaginating == false {
            dataManager.getCharactersByPage(pageNumber: page) { (result: Result<[RMCharacter], Error>) in
                switch result {
                case .success(let page):
                    self.isPaginating = true
                    self.charactersSection.append(page)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return charactersSection.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return charactersSection[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }
        
        let character = charactersSection[indexPath.section][indexPath.row]
        
        cell.name.text = character.name
        cell.type.text = character.type
        cell.specie.text = character.species
        
        DispatchQueue.global().async {
            if let url = URL(string: character.image), let data = try? Data(contentsOf: url) {
                
                DispatchQueue.main.async {
                    cell.imageCharacter.image = UIImage(data: data)
                }
                
            }
        }
        return cell
    }
    
}

extension ViewController: UITableViewDelegate {
    
    /*public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.section == tableView.numberOfSections - 1 && indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            limitCharge += 10
            print(limitCharge)
        }
    }*/
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let pos = scrollView.contentOffset.y
            if pos > (tableView.contentSize.height-100) - scrollView.frame.size.height {
                guard isPaginating == true else {
                    print("paginando")
                    return
                }
                page += 1
                isPaginating = false
                loadData(page: page)
                print(page)
            }
           
        }
    
}
