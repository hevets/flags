//
//  ViewController.swift
//  flags
//
//  Created by Stephen Henderson on 2015-11-14.
//  Copyright © 2015 hevets. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var questionTitle: UILabel!
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

        questionTitle.text = "Steve"
        
        configureUI()
        askQuestion()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func configureUI() {
        button1.layer.borderWidth = 1
        button1.layer.borderColor = UIColor.lightGrayColor().CGColor
        button2.layer.borderWidth = 1
        button2.layer.borderColor = UIColor.lightGrayColor().CGColor
        button3.layer.borderWidth = 1
        button3.layer.borderColor = UIColor.lightGrayColor().CGColor
    }

    func askQuestion(action: UIAlertAction! = nil) {
        let question = game.askQuestion()

        button1.setImage(UIImage(named: question.items[0]), forState: .Normal)
        button2.setImage(UIImage(named: question.items[1]), forState: .Normal)
        button3.setImage(UIImage(named: question.items[2]), forState: .Normal)

        questionTitle.text = formatName(question.items[question.answer])
    }

    @IBAction func buttonTapped(sender: UIButton) {
        if game.checkAnswer(sender.tag) {
            questionTitle.text = "Correct"
        } else {
            questionTitle.text = "Wrong"
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

    func formatName(name: String) -> String {
        return String(name.stringByReplacingOccurrencesOfString("_", withString: " "))
    }

}

