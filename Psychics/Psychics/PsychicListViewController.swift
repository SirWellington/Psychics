//
//  PsychicListViewController.swift
//  Psychics
//
//  Created by Wellington Moreno on 1/27/17.
//  Copyright © 2017 Wellington Moreno. All rights reserved.
//

import Foundation
import UIKit

class PsychicListViewController: UITableViewController {
    
    fileprivate let main = OperationQueue.main
    fileprivate let async: OperationQueue = {
       let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 5
        return queue
    }()
    
    fileprivate var psychics: [Psychic] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadStores()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

//MARK: API Calls 

fileprivate extension PsychicListViewController {
    
    func loadStores() {
        
        showIndicator()
        PsychicAPI.instance.loadPsychics() { psychics in
            
            defer {
                self.hideIndicator()
            }
            
            self.psychics = psychics
            
            self.main.addOperation {
                
                let section = IndexSet(integer: 0)
                self.tableView.reloadSections(section, with: .automatic)
            }
        }
    }
}

//MARK: TableView Methods
extension PsychicListViewController {
    
    var emptyCell: UITableViewCell { return UITableViewCell() }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return psychics.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PsychicCell", for: indexPath) as? PsychicCell
        else {
            return emptyCell
        }
        
        guard psychics.notEmpty else { return emptyCell }
        
        let row = indexPath.row
        guard row >= 0 && row < psychics.count else { return emptyCell }
        
        let psychic = psychics[row]
        
        loadPsychicInfo(from: psychic, to: cell)
        return cell
    }
    
    private func loadPsychicInfo(from psychic: Psychic, to cell: PsychicCell) {
        cell.psychicName.text = psychic.lineName
        cell.psychicPrice.text = "$\(psychic.basePrice)"
        cell.skills.text = psychic.skills.joined(separator: ", ")
        cell.specialties.text = psychic.specialties
        
        guard let imageUrl = psychic.images.first else { return }
        loadImage(url: imageUrl, into: cell)
    }
    
    private func loadImage(url: URL, into cell: PsychicCell) {
        
        cell.psychicCover.image = nil
        
        async.addOperation {
            
            guard let data = try? Data(contentsOf: url) else {
                print("Failed to load image from: \(url)")
                return
            }
            
            if let image = UIImage(data: data) {
                
                let animations = { cell.psychicCover.image = image }
                
                self.main.addOperation {
                    UIView.animate(withDuration: 0.3, delay: 0, options: .transitionCrossDissolve, animations: animations, completion: nil)
                }
            }
        }
    }
}


//MARK: Loading Indicator
fileprivate extension PsychicListViewController {
    
    func showIndicator() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func hideIndicator() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}
