

import UIKit
import Firebase
import FirebaseStorage

let fS = FirebaseService()
class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    var text = ""
    var noteId: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // https://medium.com/@nimjea/userdefaults-in-swift-4-d1a278a0ec79
        let defaults = UserDefaults.standard
        if let stringOne = defaults.string(forKey: String(noteId)) {

            textView.text = stringOne

            print(textView.text)
        } else {
            textView.text = text
        }
        textView.becomeFirstResponder()
    }

    @IBAction func saveOnButtonPressed(_ sender: Any) {
        let defaults = UserDefaults.standard
        defaults.set(textView.text, forKey: String(noteId))
        NoteListTableViewController.notes[noteId].text = textView.text
        print("\(textView.text!)")
    }
}
