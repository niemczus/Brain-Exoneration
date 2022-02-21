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
        
        tableView.rowHeight = UITableView.automaticDimension
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
        
        
//        let cell = UITableViewCell()
//        cell.selectionStyle = .none
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell") as? NoteCell else { return UITableViewCell() }
        
        let note = notes[indexPath.row]
        
        cell.populate(with: note)

//        var content = cell.defaultContentConfiguration()
//        content.text = note.body
//        cell.contentConfiguration = content
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let note = notes[indexPath.row]
        
        performSegue(withIdentifier: "segue.Main.notesListToNoteEditor", sender: note)
        
//        let alert = UIAlertController(title: "Update message", message: nil, preferredStyle: .alert)
//        alert.addTextField { textField in
//            textField.text = note.body
//        }
//        let updateAction = UIAlertAction(title: "Update", style: .default) { (_) in
//            guard
//                let updatedNoteBody = alert.textFields?.first?.text,
//                let appDelegate = UIApplication.shared.delegate as? AppDelegate
//            else { return }
//            note.body = updatedNoteBody
//            appDelegate.saveContext()
//
//            self.loadNotes()
//        }
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
//
//        alert.addAction(cancelAction)
//        alert.addAction(updateAction)
//
//        DispatchQueue.main.async {
//            self.present(alert, animated: true)
//        }
//
      
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCell.EditingStyle.delete {
            
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let context = appDelegate.persistentContainer.viewContext
            
            context.delete(self.notes[indexPath.row])
            appDelegate.saveContext()
            
            loadNotes()
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let noteEditorVC = segue.destination as? NoteEditorVC, let note = sender as? Note {
            noteEditorVC.note = note
        }
    }
    
}



