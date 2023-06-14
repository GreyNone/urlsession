//
//  ViewController.swift
//  urlsession
//
//  Created by Aliaksandr Vasilevich on 6/8/23.
//

import UIKit
import Alamofire
import Moya

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var button: UIButton!
    var blog = [Post]()
    var films = [Film]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(FilmTableViewCell.nib, forCellReuseIdentifier: "FilmTableViewCell")
//        getPosts()
//        fetchFilms()
    }
    
    //MARK: - Actions
    @IBAction func didClickOnButton(_ sender: Any) {
        let provider = MoyaProvider<MyService>()
        provider.request(.facts) { result in
            switch result {
            case .success(let response):
                do {
                    let facts = try response.map(Facts.self).data
                    for fact in facts {
                        self.textView.text += fact.fact
                    }
                } catch {
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func getPosts() {
        let api = "https://jsonplaceholder.typicode.com/posts"
        guard let url = URL(string: api) else { fatalError("error") }
        
        let session = URLSession(configuration: .default)
        
        let dataTask = session.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            
            DispatchQueue.main.async {
//                guard let posts = try? JSONSerialization.jsonObject(with: data) as? NSArray else { return }
                var posts = [Post]()
                posts = try! JSONDecoder().decode([Post].self, from: data)
                
                for post in posts {
                    print(post.body)
                }
//                for postDictionary in posts {
//                    guard let dictionary = postDictionary as? NSDictionary,
//                          let userId = dictionary["userId"] as? Int,
//                          let id = dictionary["id"] as? Int,
//                          let title =  dictionary["title"] as? String,
//                          let body = dictionary["body"] as? String  else { return }
//
//                    let post = Post(userId: userId,
//                                    id: id,
//                                    title: title,
//                                    body: body)
//
//                    self?.blog.append(post)
//                }
            }
        }
        dataTask.resume()
    }
    
    @IBAction func goToMoya(_ sender: Any) {
        let moyaStoryboard = UIStoryboard(name: "MoyaStoryboard", bundle: nil)
        let moyaViewController = moyaStoryboard.instantiateViewController(withIdentifier: "MoyaViewController")
        self.navigationController?.pushViewController(moyaViewController, animated: true)
    }
    
    @IBAction func goToDogs(_ sender: Any) {
        let dogsStoryboard = UIStoryboard(name: "DogsStoryboard", bundle: nil)
        let dogsViewController = dogsStoryboard.instantiateViewController(withIdentifier: "DogsViewController")
        self.navigationController?.pushViewController(dogsViewController, animated: true)
    }
    
    private func fetchFilms() {
        let request = AF.request("https://swapi.dev/api/films", method: HTTPMethod.get)
        request.validate()
            .responseDecodable(of: Films.self) { [weak self] (response) in
                guard let fetchedFilms = response.value else { return }
                self?.films = fetchedFilms.all
                self?.tableView.reloadData()
            }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return films.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FilmTableViewCell.identifier) as! FilmTableViewCell
        let film = films[indexPath.row]
        
        cell.titleLabel.text = film.title
        cell.episodeLabel.text = "Episode \(film.id)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let film = films[indexPath.row]
        
        let storyboard = UIStoryboard(name: "DescriptionStoryboard", bundle: nil)
        guard let descriptionViewController = storyboard.instantiateViewController(withIdentifier: "DescriptionViewController")
                as? DescriptionViewController else { return }
        descriptionViewController.titleForHeader = film.title
        descriptionViewController.episode = film.id
        descriptionViewController.director = film.director
        descriptionViewController.producer = film.producer
        descriptionViewController.releaseDate = film.releaseDate
        descriptionViewController.list = film.starships
        
        self.navigationController?.pushViewController(descriptionViewController, animated: true)
    }
}


