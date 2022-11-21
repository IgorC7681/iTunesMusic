//
//  TableViewController.swift
//  iTunesMusic
//
//  Created by TaiYi Chien on 2022/11/18.
//

import UIKit

class TableViewController: UITableViewController {
    
    var items = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    func initUI() {
        self.navigationItem.title = "Search Music"
        tableView.rowHeight = 118
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 44))
        searchBar.delegate = self
        searchBar.placeholder = "Please enter key words"
        tableView.tableHeaderView = searchBar
        //let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyBoard))
        //tap.cancelsTouchesInView = false
        //tableView.addGestureRecognizer(tap)
    }
    /*
    @objc func dismissKeyBoard() {
        tableView.endEditing(true)
    }
    */
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as? TableViewCell else { return UITableViewCell() }
        fetchImage(from: items[indexPath.row].artworkUrl100) { result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    if indexPath == self.tableView.indexPath(for: cell) {
                        cell.coverImageView.image = image
                    }
                }
            case .failure(let error):
                print("ERROR：\(error)")
            }
        }
        cell.trackNameLabel.text = items[indexPath.row].trackName
        cell.artistNameLabel.text = items[indexPath.row].artistName
        cell.collectionNameLabel.text = items[indexPath.row].collectionName
        
        return cell
    }
    
}
// MARK: - Extension
extension TableViewController {
    func fetchItem(matching query: [String: String], completion: @escaping(Result<[Item], Error>) -> () ) {
        var urlComponents = URLComponents(string: "https://itunes.apple.com/search")!
        urlComponents.queryItems = query.map { URLQueryItem(name: $0.key, value: $0.value) }
        URLSession.shared.dataTask(with: urlComponents.url!) { (data, reponse, error) in
            if let data = data {
                do {
                    let response = try JSONDecoder().decode(Data.self, from: data)
                    completion(.success(response.results))
                } catch {
                    completion(.failure(error))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func fetchImage(from url: URL, completion: @escaping(Result<UIImage, Error>) -> () ) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data, let image = UIImage(data: data) {
                completion(.success(image))
            } else if let error = error {
                completion(.failure(error))
            }
        }.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "play" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let showVC = segue.destination as! ViewController
                showVC.imageUrl = items[indexPath.row].artworkUrl100.description
                showVC.playUrl = items[indexPath.row].previewUrl.description
            }
        }
    }
}

extension TableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let term = searchBar.text, term.isEmpty == false {
            let query = ["term": term, "media": "music"]
            fetchItem(matching: query) { result in
                switch result {
                case .success(let response):
                    self.items = response
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                case .failure(let error):
                    print("ERROR：\(error)")
                }
            }
        }
        searchBar.resignFirstResponder()
    }
}
