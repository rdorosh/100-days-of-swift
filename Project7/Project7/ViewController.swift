//
//  ViewController.swift
//  Project7
//
//  Created by Ruslan Dorosh on 20.06.2022.
//

import UIKit

class ViewController: UITableViewController {
    var petitions = [Petition]()
    var filteredPetitions = [Petition]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Petitions"
        
        let urlString: String
        
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
            } else {
                showError()
            }
        } else {
                showError()
            }
        
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(filterPetitions))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(creditsShow))
        
        }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            filteredPetitions = jsonPetitions.results
            tableView.reloadData()
        }
    }
    
    func showError() {
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPetitions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = petitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func creditsShow() {
        let creditsAlert = UIAlertController(title: "Credits", message: nil, preferredStyle: .alert)
        creditsAlert.addAction(UIAlertAction(title: "We The People API of the Whitehouse.", style: .default, handler: nil))
        present(creditsAlert, animated: true)
    }
    
    @objc func filterPetitions() {
        let ac = UIAlertController(title: "Enter keyword to filter", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Search", style: .default) {
            [weak self, weak ac] _ in
            guard let searchTerm = ac?.textFields?[0].text else { return }
            self?.submit(searchTerm)
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    func submit(_ searchTerm: String) {
            // Empty out the filteredPetitions
            filteredPetitions.removeAll(keepingCapacity: true)
            
            // Get lowercased version of the search word
            let word = searchTerm.lowercased()
            
            // Look through the array of Structs for the term
            // and copy those entries into filteredPetitions
            if word == "" {
                filteredPetitions = petitions
                title = "Petitions"
            } else {
                for petition in petitions {
                    if petition.title.lowercased().contains(word) || petition.body.lowercased().contains(word) {
                        filteredPetitions.append(petition)
                    }
                }
                title = "Filter: \(word)"
            }
            
            // Reload the tableView
            tableView.reloadData()
            
        }

}

