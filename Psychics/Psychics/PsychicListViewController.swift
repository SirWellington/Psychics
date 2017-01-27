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
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return psychics.count
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
