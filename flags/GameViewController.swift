//
//  ViewController.swift
//  flags
//
//  Created by Stephen Henderson on 2015-11-14.
//  Copyright © 2015 hevets. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var rightLabel: UILabel!
    @IBOutlet weak var wrongLabel: UILabel!

    var game:Game!

    override func viewDidLoad() {
        super.viewDidLoad()

        // load the flags for the game
        let path = NSBundle.mainBundle().pathForResource("countries", ofType: "txt")!
        let countryNames = try! String(contentsOfFile: path).stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        let countries = countryNames.componentsSeparatedByString("\n")

        game = Game(newItems: countries)


        configureUI()
        askQuestion()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .Default
    }

    func configureUI() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        view.backgroundColor = UIColor.flatWhiteColor()
        styleButton(button1, button2, button3)
    }

    func styleButton(buttons: UIButton...) {
        for button in buttons {
            button.layer.cornerRadius = 6.0
            button.layer.masksToBounds = true
        }
    }

    func askQuestion(action: UIAlertAction! = nil) {
        let question = game.askQuestion()

        button1.setImage(UIImage(named: question.items[0]), forState: .Normal)
        button2.setImage(UIImage(named: question.items[1]), forState: .Normal)
        button3.setImage(UIImage(named: question.items[2]), forState: .Normal)
        self.enableButtons(button1, button2, button3)

        self.navigationItem.title = formatName(question.items[question.answer])
    }

    @IBAction func buttonTapped(sender: UIButton) {
        disableButtons(button1, button2, button3)

        if game.checkAnswer(sender.tag) {
            self.navigationItem.title = "Correct"
        } else {
            self.navigationItem.title = "Wrong"
        }

        updateView()
    }

    func updateView() {
        rightLabel.text = "Right: \(game.right)"
        wrongLabel.text = "Wrong: \(game.wrong)"

        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(1500 * Double(NSEC_PER_MSEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            self.askQuestion()
        }
    }

    func disableButtons(buttons: UIButton...) {
        for button in buttons {
            button.enabled = false
        }
    }

    func enableButtons(buttons: UIButton...) {
        for button in buttons {
            button.enabled = true
        }
    }

    func formatName(name: String) -> String {
        return String(name.stringByReplacingOccurrencesOfString("_", withString: " "))
    }
    
}

