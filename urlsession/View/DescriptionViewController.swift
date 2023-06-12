//
//  DescriptionViewController.swift
//  urlsession
//
//  Created by Aliaksandr Vasilevich on 6/9/23.
//

import UIKit
import Alamofire

class DescriptionViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var titleForHeader: String?
    var episode: Int?
    var director: String?
    var producer: String?
    var releaseDate: String?
    var titles = [String]()
    var data = [String]()
//    var descriptionData = [(String, Any)]()
    var starships = [Starship]()
    var list = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let episode = episode,
              let title = titleForHeader,
              let director = director,
              let producer = producer,
              let releaseDate = releaseDate else { return }
        titles.append(contentsOf: [title,"DIRECTORS","PRODUCER","RELEASE DATE","STARSHIPS"])
        data.append(contentsOf: ["Episode \(episode)",director,producer,releaseDate,""])
//        let titles = [title,"DIRECTORS","PRODUCER","RELEASE DATE","STARSHIPS"]
//        let data = ["Episode \(episode)",director,producer,releaseDate,nil]
//        if titles.count == data.count {
//            for i in 0...titles.count - 1 {
//                let title = titles[i]
//                let data = data[i]
//                descriptionData.append((title,data as Any))
//            }
//        }
        
        tableView.register(DescriptionTableViewCell.nib, forCellReuseIdentifier: DescriptionTableViewCell.identifier)
//        getStarships(list: list)
    }
    
//    func getStarships(list: [String]) {
//        let fetchGroup = DispatchGroup()
//        var items: [Starship] = []
//        list.forEach { (url) in
//            fetchGroup.enter()
//            AF.request(url).validate().responseDecodable(of: Starship.self) { (response) in
//                if let value = response.value {
//                    items.append(value)
//                }
//                fetchGroup.leave()
//            }
//        }
//        
//        fetchGroup.notify(queue: .main) { [weak self] in
//            self?.starships = items
//        }
//    }
}

extension DescriptionViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return titles.count
//        return descriptionData.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return titles[section]
//        let section = descriptionData[section]
//        return section.0
    }
    
//    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
//        if section == 0 {
//            guard let header = view as? UITableViewHeaderFooterView else { return }
//            header.textLabel?.textColor = .black
//            header.textLabel?.font = UIFont.boldSystemFont(ofSize: 15)
//        }
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
//        let section = descriptionData[section]
//        return section.1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DescriptionTableViewCell.identifier) as? DescriptionTableViewCell
              else { return DescriptionTableViewCell() }
        
        cell.descriptionLabel.text = data[indexPath.section]
        
        return cell
    }
}
