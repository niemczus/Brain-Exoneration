//
//  ViewController.swift
//  Brain Exoneration
//
//  Created by Kamil Niemczyk on 16/02/2022.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var notes = [Note]()
    
    
    override func viewDidLoad() {
          super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        loadNotes()
      }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadNotes()
    }
    
    func loadNotes() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        
        do {
            let fetchedObjects = try context.fetch(fetchRequest)
            guard let notes = fetchedObjects as? [Note] else { return }
            
            self.notes = notes
            tableView.reloadData()
            
        } catch {
            print(error)
        }
    }

    
    @IBAction func didTapAdd(_ sender: Any) {
        
        performSegue(withIdentifier: "segue.Main.notesListToNoteEditor", sender: nil)
    
//        let alert = UIAlertController(title: "Add note", message: nil, preferredStyle: .alert)
//        alert.addTextField()
//
//        let saveAction = UIAlertAction(title: "Save", style: .default) { (_) in
//
//            guard
//                let noteBody = alert.textFields?.first?.text,
//                let appDelegate = UIApplication.shared.delegate as? AppDelegate
//            else { return }
//
//            let context = appDelegate.persistentContainer.viewContext
//
//            let newNote = Note(context: context)
//            newNote.body = noteBody
//
//            self.notes.append(newNote)
//            self.tableView.reloadData()
//        }
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
//
//        alert.addAction(cancelAction)
//        alert.addAction(saveAction)
//
//        DispatchQueue.main.async {
//            self.present(alert, animated: true)
//        }
//
    }
    
    //MARK: - TableView Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let note = notes[indexPath.row]
        
        let cell = UITableViewCell()
        cell.selectionStyle = .none
        
        var content = cell.defaultContentConfiguration()
        
        content.text = note.body
        
        cell.contentConfiguration = content
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let note = notes[indexPath.row]
        
        let alert = UIAlertController(title: "Update message", message: nil, preferredStyle: .alert)
        alert.addTextField { textField in
            textField.text = note.body
        }
        let updateAction = UIAlertAction(title: "Update", style: .default) { (_) in
            guard
                let updatedNoteBody = alert.textFields?.first?.text,
                let appDelegate = UIApplication.shared.delegate as? AppDelegate
            else { return }
            note.body = updatedNoteBody
            appDelegate.saveContext()
            
            self.loadNotes()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(cancelAction)
        alert.addAction(updateAction)
        
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
        
      
    }
    
    
    
}



