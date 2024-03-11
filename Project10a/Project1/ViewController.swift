//
//  ViewController.swift
//  Project1
//
//  Created by Ruslan Dorosh on 29.04.2022.
//

import UIKit

class ViewController: UICollectionViewController {
    var pictures = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        performSelector(inBackground: #selector(loadPictures), with: nil)
    }
    
    @objc func loadPictures() {
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }
        }
        pictures.sort()
        
        print(pictures)
        
        collectionView.performSelector(onMainThread: #selector(UICollectionView.reloadData), with: nil, waitUntilDone: false)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Picture", for: indexPath) as? ImageCell {
         
            cell.imageView.image = UIImage(named: pictures[indexPath.row])
            cell.imageLabel?.text = pictures[indexPath.row]
            return cell
        }
        fatalError("Unable to dequeue an ImageCell")
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row]
            
            vc.position = (position: indexPath.row + 1, total: pictures.count)
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }

    @objc func shareTapped() {
            var items: [Any] = ["This app is great, you should try it!"]
            if let url = URL(string: "https://www.hackingwithswift.com/100/16") {
                items.append(url)
            }
            
            let vc = UIActivityViewController(activityItems: items, applicationActivities: [])
            vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
            present(vc, animated: true)
        }

}

