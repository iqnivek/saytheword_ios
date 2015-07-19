//
//  MasterViewController.swift
//  SayTheWord
//
//  Created by Kevin Qi on 7/5/15.
//  Copyright (c) 2015 Kevin Qi. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {
    var wordLists = [WordList]()

    func loadWordLists() {
        // TODO add word_lists#index action
        RKObjectManager.sharedManager().getObjectsAtPath("/v1/word_lists/1.json", parameters: nil,
            success: { (operation, result) -> Void in
                self.wordLists = result.array() as! [WordList]
                self.tableView.reloadData()
            },
            failure: { (operation, error) -> Void in
                println("loadWordLists failed: \(error)")
            }
        )
    }
    
    func configureRestKit() {
        let objectManager = RKObjectManager(baseURL: NSURL(string: "http://localhost:3000"))

        let responseMapping = RKObjectMapping(forClass: WordList.self)
        responseMapping.addAttributeMappingsFromArray(["id", "name", "words"])

        let requestMapping = RKObjectMapping.requestMapping()
        requestMapping.addAttributeMappingsFromArray(["id", "name", "words"])

        // GET
        let getResponseDescriptor = RKResponseDescriptor(mapping: responseMapping, method: RKRequestMethod.GET, pathPattern: "/v1/word_lists/:id.json", keyPath: "word_list", statusCodes: NSIndexSet(index: 200))

        // UPDATE
        let updateResponseDescriptor = RKResponseDescriptor(mapping: responseMapping, method: RKRequestMethod.PUT, pathPattern: "/v1/word_lists/:id.json", keyPath: "word_list", statusCodes: RKStatusCodeIndexSetForClass(RKStatusCodeClass.Successful))
        let updateRequestDescriptor = RKRequestDescriptor(mapping: requestMapping, objectClass: WordList.self, rootKeyPath: "word_list", method: RKRequestMethod.Any)

        objectManager.addRequestDescriptor(updateRequestDescriptor)
        objectManager.addResponseDescriptor(getResponseDescriptor)
        objectManager.addResponseDescriptor(updateResponseDescriptor)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureRestKit()
        self.loadWordLists()
        
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()

        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
        self.navigationItem.rightBarButtonItem = addButton
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func insertNewObject(sender: AnyObject) {
        /*
        objects.insert(NSDate(), atIndex: 0)
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        */
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let object = wordLists[indexPath.row]
                (segue.destinationViewController as! DetailViewController).wordList = object
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wordLists.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("WordListCell", forIndexPath: indexPath) as! UITableViewCell

        let wordList = wordLists[indexPath.row]
        cell.textLabel!.text = wordList.name as? String
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        /*
        if editingStyle == .Delete {
            objects.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
        */
    }


}

