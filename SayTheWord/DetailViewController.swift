//
//  DetailViewController.swift
//  SayTheWord
//
//  Created by Kevin Qi on 7/5/15.
//  Copyright (c) 2015 Kevin Qi. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!

    var wordList: WordList? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        if let wl = self.wordList, label = detailDescriptionLabel {
            label.text = wl.name as? String
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

