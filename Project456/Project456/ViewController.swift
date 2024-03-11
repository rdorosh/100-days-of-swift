//
//  ViewController.swift
//  Project456
//
//  Created by Ruslan Dorosh on 17.06.2022.
//

import UIKit

class ViewController: UITableViewController {
    var shoppingList = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForProduct))
        let shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        navigationItem.rightBarButtonItems = [addButton, shareButton]
        
        navigationItem.leftBarButtonItem =
                UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(startGame))
        
        startGame()
    }
    
    @objc func startGame() {
        title = "Shopping list"
        shoppingList.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Product", for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row]
        return cell
    }
    
    @objc func promptForProduct() {
        let ac = UIAlertController(title: "Enter product", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) {
            [weak self, weak ac] _ in
            guard let product = ac?.textFields?[0].text else { return }
            self?.submit(product)
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    func submit(_ product: String) {
        shoppingList.insert(product, at: 0)
        
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    @objc func shareTapped() {
            let list = shoppingList.joined(separator: "\n")
            
            let avc = UIActivityViewController(activityItems: [list], applicationActivities: nil)
            avc.popoverPresentationController?.barButtonItem = navigationItem.leftBarButtonItem
            present(avc, animated: true)
        }

}

