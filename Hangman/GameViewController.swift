//
//  GameViewController.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var word: UILabel!
    var globalPhrase = "";
    var buttonsPressed = [String]()
    var index = 0

    @IBOutlet weak var missLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = UIImage(named: "\(index)")

        // Do any additional setup after loading the view.
        let hangmanPhrases = HangmanPhrases()
        let phrase = hangmanPhrases.getRandomPhrase()
        print(phrase)
        globalPhrase = phrase!;
        
        buttonsPressed = []
        missLabel.text = ""
        index = 0
        imageView.image = UIImage(named: "0")
        word.text = ""
        for i in (phrase?.characters)! {
            if i==" " {
                word.text! += "  ";
            } else {
                word.text! += "_ ";
            }
        }
        
    }
    

    @IBAction func buttonPressed(_ sender: AnyObject) {
        word.text = ""
        
        buttonsPressed.append(sender.currentTitle!!)
        
        if !globalPhrase.contains(sender.currentTitle!!.uppercased()) {
            missLabel.text?.append(sender.currentTitle!!);
            index += 1
            imageView.image = UIImage(named: "\(index)")
            
            if index == 6 {
                
                let alertController = UIAlertController(title: "Sucks to Suck", message: "The phrase is \(globalPhrase)", preferredStyle: .alert)
                    
                alertController.addAction(UIAlertAction(title: "Start Over", style: .cancel, handler: {
                    action in
                    self.viewDidLoad();
                    
                }))
                present(alertController, animated: true, completion: nil)
                
            }

        }
        
        for i in globalPhrase.characters {
            if buttonsPressed.contains(String(i).lowercased()) {
                word.text = word.text! + String(i) + " ";
            }
            else if i == " " {
                word.text = word.text! +  "  ";
            } else {
                word.text = word.text! + "_ ";
            }
        }
        
        if (!(word.text?.contains("_"))!) {
            let alertController = UIAlertController(title: "You Win", message: "Keep It Up Champ!", preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "Start Over", style: .cancel, handler: {
                action in
                self.viewDidLoad();
                
            }))
            present(alertController, animated: true, completion: nil)
            
        }
        super.viewDidLoad()


        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
