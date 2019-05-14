

import UIKit

class NoteListTableViewController: UITableViewController {

    static var notes = [Note]()

    var newNote: Note?

    static var noteIdCounter = 0

    var currentNote = ""
    var currentNoteId = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        NoteListTableViewController.notes.removeAll()

        currentNoteId = 0

       
       while true {
            if let string = UserDefaults.standard.string(forKey: String(currentNoteId)) {
                NoteListTableViewController.notes.append(Note(noteId: currentNoteId, text: string))
              currentNoteId += 1
            } else {
                break
            }
       
        }
         tableView?.reloadData()
    }
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NoteListTableViewController.notes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.text = "\(NoteListTableViewController.notes[indexPath.row].text)"

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentNote = NoteListTableViewController.notes[indexPath.row].text
        currentNoteId = NoteListTableViewController.notes[indexPath.row].noteId
        performSegue(withIdentifier: "showDetail", sender: nil)
        NoteListTableViewController.noteIdCounter = 0
    }

    @IBAction func cancel(segue: UIStoryboardSegue) {
        NoteListTableViewController.noteIdCounter = 0
    }

    @IBAction func done(segue: UIStoryboardSegue) {
        let noteDetailViewController = segue.source as! NoteDetailViewController
        newNote = Note(noteId: NoteListTableViewController.noteIdCounter, text: noteDetailViewController.text ?? "Automated text...")

        NoteListTableViewController.notes.append(newNote ?? Note(noteId: NoteListTableViewController.noteIdCounter, text: "Automated text..."))

        print(newNote!.noteId)

        let defaults = UserDefaults.standard
        defaults.set(newNote!.text, forKey: String(newNote!.noteId))


        NoteListTableViewController.noteIdCounter = 0
        tableView.reloadData()
    }

    


    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        if editingStyle == .delete {
            NoteListTableViewController.notes.remove(at: indexPath.row)
            UserDefaults.standard.removeObject(forKey: String(indexPath.row))
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
            tableView.insertRows(at: [indexPath], with: .fade)
        }
    }

   


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? ViewController {
            viewController.text = currentNote
            viewController.noteId = currentNoteId
            //print(currentNoteId)
        }
    }
}
