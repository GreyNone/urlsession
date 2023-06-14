//
//  DogsViewController.swift
//  urlsession
//
//  Created by Aliaksandr Vasilevich on 6/13/23.
//

import UIKit
import Alamofire
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
            if count == 0 {
                return 1
            } else {
                return count
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let keys = keys,
              let dogs = dogs else { return DogsTableViewCell() }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: DogsTableViewCell.identifier) as! DogsTableViewCell
        let key = keys[indexPath.section]
        let value = dogs[key]
        
        if let value = value {
            let count = value.count
            if count == 0 {
                cell.request = AF.request("https://dog.ceo/api/breed/" + key + "/images/random", method: HTTPMethod.get)
                cell.request?.validate().responseDecodable(of: DogsImages.self) { (response) in
                        guard let value = response.value else { return }
                        let url = URL(string: value.message)!
                        cell.configure(name: "", imageUrl: url)
                    }
            } else {
                let dogName = value[indexPath.row]
                cell.request = AF.request("https://dog.ceo/api/breed/" + key + "/images/random", method: HTTPMethod.get)
                cell.request?.validate().responseDecodable(of: DogsImages.self) { (response) in
                    guard let value = response.value else { return }
                    let url = URL(string: value.message)!
                    cell.configure(name: dogName, imageUrl: url)
                }
            }
        }
        
        return cell
    }
}
