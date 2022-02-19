//
//  NoteEditorVC.swift
//  Brain Exoneration
//
//  Created by Kamil Niemczyk on 19/02/2022.
//

import UIKit

class NoteEditorVC: UIViewController {

    @IBOutlet weak var noteTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .white
        
        let doneButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(didTapDone))
        
        navigationItem.rightBarButtonItem = doneButtonItem
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        noteTextView.becomeFirstResponder()
    }
    
    @objc func didTapDone() {
        print("Done")
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let newNote = Note(context: context)
        newNote.body = noteTextView.text
        
        appDelegate.saveContext()
        
        navigationController?.popViewController(animated: true)
        
    }
    
}
