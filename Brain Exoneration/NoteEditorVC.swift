//
//  NoteEditorVC.swift
//  Brain Exoneration
//
//  Created by Kamil Niemczyk on 19/02/2022.
//

import UIKit

class NoteEditorVC: UIViewController {

    @IBOutlet weak var noteTextView: UITextView!
    
    var note: Note?
    var didUserSave = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .white
        
        let doneButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(didTapDone))
        navigationItem.rightBarButtonItem = doneButtonItem
        
        if let note = note {
            noteTextView.text = note.body
            navigationItem.title = "Edit note"
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        noteTextView.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if didUserSave == false {
            saveNote()
        }
    }
    
    func saveNote() {
        guard
            let appDelegate = UIApplication.shared.delegate as? AppDelegate,
            !noteTextView.text.isEmpty
        else { return }
        
        let context = appDelegate.persistentContainer.viewContext
        
        if let note = note {
            note.body = noteTextView.text
        } else {
            let newNote = Note(context: context)
            newNote.body = noteTextView.text
        }
        
        appDelegate.saveContext()
    }
    
    @objc func didTapDone() {
        print("Done")
        
        saveNote()
        
        didUserSave = true
        
        navigationController?.popViewController(animated: true)
        
    }
    
}
