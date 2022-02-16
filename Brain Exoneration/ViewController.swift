//
//  ViewController.swift
//  Brain Exoneration
//
//  Created by Kamil Niemczyk on 16/02/2022.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var notes = ["hello", "goodbye"]
    
    
    
    
    override func viewDidLoad() {
          super.viewDidLoad()
        
        tableView.dataSource = self
          
      }

    
    @IBAction func didTapAdd(_ sender: Any) {
        print("add")
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let note = notes[indexPath.row]
        
        let cell = UITableViewCell()
        
        var content = cell.defaultContentConfiguration()
        
        content.text = note
        
        cell.contentConfiguration = content
        
        return cell
    }
    
    
    
    
}



