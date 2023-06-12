//
//  MoyaViewController.swift
//  urlsession
//
//  Created by Aliaksandr Vasilevich on 6/12/23.
//

import UIKit
import Moya

class MoyaViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var breeds = [Breed]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(BreedTableViewCell.nib, forCellReuseIdentifier: BreedTableViewCell.identifier)
        
        let provider = MoyaProvider<MyService>()
        provider.request(.breeds) { [weak self] result in
            switch result {
            case .success(let response):
                do {
                    self?.breeds = try response.map((Breeds).self).data
                    self?.tableView.reloadData()
                } catch {
                    print(error)
                }
            case .failure:
                break
            }
        }
    }
}

extension MoyaViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        breeds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BreedTableViewCell.identifier) as! BreedTableViewCell
        let breed = breeds[indexPath.row]
        
        cell.breedLabel.text = breed.breed
        cell.countryLabel.text = breed.country
        cell.originLabel.text = breed.country
        cell.coatLabel.text = breed.coat
        cell.patternLabel.text = breed.pattern
        
        return cell
    }
    
    
}
