import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    var count = 1
    var activePlayer = 1 //Cross = 1 circle = 2
    var gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    var gameIsActive = true
    let winningCombinations = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
    @IBOutlet weak var playAgain: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func btnClicked(_ sender: AnyObject) {
        print("btn pressed \(sender.tag)")
        if (gameState[sender.tag-1] == 0 && gameIsActive == true) {
            gameState[sender.tag-1] = activePlayer
            if (activePlayer == 1){
                sender.setImage(UIImage(named: "X"), for: UIControl.State())
                activePlayer = 2
            }else {
                sender.setImage(UIImage(named: "O"), for: UIControl.State())
                activePlayer = 1
            }
        }
        for combination in winningCombinations {
            if gameState[combination[0]] != 0 && gameState[combination[0]] == gameState[combination[1]] && gameState[combination[1]] == gameState[combination[2]] {
                gameIsActive = false
                
                if gameState[combination[0]] == 1{
                    label.text = "Cross has won!"
                } else {
                    label.text = "Circle has won!"
                    
                }
                if gameIsActive == true {
                    for i in gameState {
                        count = i*count
                    }
                    if count != 0 {
                        label.text = "It was a draw!"
                        label.isHidden = false
                        playAgain.isHidden = false
                    }
                }
                playAgain.isHidden = false
                label.isHidden = false
            }
        }
    }
    
    
    @IBAction func playAgain(_ sender: Any) {
    
    label.text = ""
        gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
        gameIsActive = true
        activePlayer = 1
        playAgain.isHidden = true
        label.isHidden = true
        for i in 1...9 {
            let button = view.viewWithTag(i) as! UIButton
            button.setImage(nil, for: UIControl.State())
        }
    }
    
}
