//
//  Note.swift
//  My Notebook
//
//  Created by Martin Løseth Jensen on 23/03/2019.
//  Copyright © 2019 Martin Løseth Jensen. All rights reserved.
//

import Foundation

class Note {
    let noteId: Int
    var text: String

    init(noteId: Int, text: String) {
        self.noteId = noteId
        self.text = text
        NoteListTableViewController.noteIdCounter += 1
    }
}
