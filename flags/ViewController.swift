//
//  ViewController.swift
//  flags
//
//  Created by Stephen Henderson on 2015-11-14.
//  Copyright © 2015 hevets. All rights reserved.
//

import UIKit
import GameplayKit

class ViewController: UIViewController {

    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var rightLabel: UILabel!
    @IBOutlet weak var wrongLabel: UILabel!

    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var right = 0
    var wrong = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureImages()
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

    func configureImages() {
        let path = NSBundle.mainBundle().pathForResource("countries", ofType: "txt")!
        let countryNames = try! String(contentsOfFile: path).stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        countries += countryNames.componentsSeparatedByString("\n")
    }

    func askQuestion(action: UIAlertAction! = nil) {
        countries = GKRandomSource.sharedRandom().arrayByShufflingObjectsInArray(countries) as! [String]
        button1.setImage(UIImage(named: countries[0]), forState: .Normal)
        button2.setImage(UIImage(named: countries[1]), forState: .Normal)
        button3.setImage(UIImage(named: countries[2]), forState: .Normal)
        correctAnswer = GKRandomSource.sharedRandom().nextIntWithUpperBound(3)
        title = formatName(countries[correctAnswer].uppercaseString)
    }

    @IBAction func buttonTapped(sender: UIButton) {
        if sender.tag == correctAnswer {
            title = "Correct"
            ++score
            ++right
        } else {
            title = "Wrong"
            --score
            ++wrong
        }

        updateView()
    }

    func updateView() {
        rightLabel.text = "Right: \(right)"
        wrongLabel.text = "Wrong: \(wrong)"

        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(1500 * Double(NSEC_PER_MSEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            self.askQuestion()
        }
    }

    func formatName(name: String) -> String {
        return String(name.stringByReplacingOccurrencesOfString("_", withString: " "))
    }
    
}

