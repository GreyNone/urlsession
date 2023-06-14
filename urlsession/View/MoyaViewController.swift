//
//  MoyaViewController.swift
//  urlsession
//
//  Created by Aliaksandr Vasilevich on 6/12/23.
//

import UIKit
import Moya
import Alamofire

class MoyaViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var breeds = [Breed]()
    var currentBreeds: Breeds?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(BreedTableViewCell.nib, forCellReuseIdentifier: BreedTableViewCell.identifier)
        
        let provider = MoyaProvider<MyService>()
        provider.request(.breeds) { [weak self] result in
            switch result {
            case .success(let response):
                do {
                    self?.currentBreeds = try response.map((Breeds).self)
                    self?.breeds.append(contentsOf: try response.map((Breeds).self).data)
                    self?.tableView.reloadData()
                } catch {
                    print(error)
                }
            case .failure:
                break
            }
        }
    }
    
    private func countPreviousRows(for sections: Int) -> Int {
        guard sections >= 0 else { return 0 }
        var rows = 0
        var i = 0
        repeat {
            rows += self.tableView.numberOfRows(inSection: i)
            i += 1
        } while i < sections
        return rows
    }
    
    private func countAllRows() -> Int {
        var rows = 0
        for i in 0...tableView.numberOfSections - 1 {
            rows += tableView.numberOfRows(inSection: i)
        }
        return rows
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let currentBreeds = currentBreeds,
              let nextPageUrl = currentBreeds.nextPageUrl  else { return }
        if countPreviousRows(for: indexPath.section - 1) + indexPath.row == countAllRows() - 3 {
            let provider = MoyaProvider<MyService>()
            provider.request(.nextBreeds(url: nextPageUrl)) { [weak self] result in
                switch result {
                case .success(let response):
                    self?.currentBreeds = try? response.map(Breeds.self)
                    self?.breeds.append(contentsOf: self?.currentBreeds?.data ?? [])
                    self?.tableView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
