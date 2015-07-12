//
//  DetailViewController.swift
//  SayTheWord
//
//  Created by Kevin Qi on 7/5/15.
//  Copyright (c) 2015 Kevin Qi. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var wordCountLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!

    @IBAction func editWordList(sender: AnyObject) {

    }

    @IBAction func startGame(sender: AnyObject) {

    }

    var wordList: WordList? {
        didSet {
            self.configureView()
        }
    }

    func configureView() {
        if let wl = self.wordList {
            if let label = wordCountLabel {
                label.text = "\(wl.words?.count ?? 0) words"
            }
            if let label = nameLabel {
                label.text = wl.name as? String
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

