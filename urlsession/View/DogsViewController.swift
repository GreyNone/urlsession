//
//  DogsViewController.swift
//  urlsession
//
//  Created by Aliaksandr Vasilevich on 6/13/23.
//

import UIKit
import Moya

class DogsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var dogs: [String: [String]]?
    var keys: [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(DogsTableViewCell.nib, forCellReuseIdentifier: DogsTableViewCell.identifier)
        
        let provider = MoyaProvider<MyService>()
        provider.request(.dogs) { [weak self] result in
            switch result {
            case .success(let response):
                do {
                    let response = try response.map(Dogs.self)
                    self?.dogs = response.data
                    self?.keys = []
                    for key in response.data.keys {
                        self?.keys?.append(key)
                    }
                    self?.tableView.reloadData()
                } catch {
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

extension DogsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let count = dogs?.count else { return 0 }
        return count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let keys = keys else { return "" }
        return keys[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let keys = keys,
              let dogs = dogs else { return 0 }
        let key = keys[section]
        let value = dogs[key]
        if let value = value {
            let count = value.count
            return count == 0 ? 1 : count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let keys = keys,
              let dogs = dogs else { return DogsTableViewCell() }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: DogsTableViewCell.identifier) as! DogsTableViewCell
        cell.activityIndicatorView.startAnimating()
        
        let section = keys[indexPath.section]
        guard let value = dogs[section] else { return DogsTableViewCell() }
        
        let count = value.count
        let name = count == 0 ? nil : value[indexPath.row]
        let key = count == 0 ? section : name! + section
        
        if let image = CacheManager.shared.getValue(for: key) {
            cell.configure(name: name, image: image)
            cell.activityIndicatorView.stopAnimating()
            return cell
        }
        
        let provider = MoyaProvider<MyService>()
        cell.request = provider.request(.dogsImages(url: section)) { result in
            switch result {
            case .success(let response):
                do {
                    let url = try response.map(DogsImages.self).message
                    cell.configure(name: name, imageUrl: URL(string: url)!, key: key)
                } catch {
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
