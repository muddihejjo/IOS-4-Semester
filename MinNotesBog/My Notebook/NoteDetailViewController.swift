

import UIKit

class NoteDetailViewController: UIViewController {

    @IBOutlet weak var noteTextField: UITextView!

    var text: String? = nil

    override func viewDidLoad() {
        super.viewDidLoad()


        // Do any additional setup after loading the view.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "doneSegue" {
            text = noteTextField.text!
        }
    }


}
