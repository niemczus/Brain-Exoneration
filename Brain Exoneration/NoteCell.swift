//
//  NoteCell.swift
//  Brain Exoneration
//
//  Created by Kamil Niemczyk on 21/02/2022.
//

import UIKit

class NoteCell: UITableViewCell {
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var noteBodyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func populate(with note: Note) {
        categoryLabel.text = note.category
        noteBodyLabel.text = note.body
    }
    
}
