//
//  EditWordListTableViewController.swift
//  SayTheWord
//
//  Created by Kevin Qi on 7/12/15.
//  Copyright (c) 2015 Kevin Qi. All rights reserved.
//

import UIKit

class EditWordListTableViewController: UITableViewController {
    var wordList: WordList? {
        didSet {

        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let addButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "addWord")
        self.navigationItem.rightBarButtonItems = [addButton, self.editButtonItem()]
    }

    func addWord() {
        var alert = UIAlertController(title: "Add a new word", message: nil, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Add", style: .Default, handler: { (action: UIAlertAction!) -> Void in
            let text = (alert.textFields?[0] as! UITextField).text
            let newList = self.wordList!.words!.mutableCopy() as! NSMutableArray
            newList.addObject(text)
            self.wordList!.words = newList
            self.tableView.reloadData()

            RKObjectManager.sharedManager().patchObject(self.wordList, path: "/v1/word_lists/\(self.wordList!.id!).json", parameters: nil, success: nil, failure: nil)
        }))
        alert.addTextFieldWithConfigurationHandler() { (textField: UITextField!) in
            textField.placeholder = "e.g. pumpkin"
        }
        self.presentViewController(alert, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wordList?.words?.count ?? 0
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("WordCell", forIndexPath: indexPath) as! UITableViewCell

        cell.textLabel!.text = wordList?.words?[indexPath.row] as? String

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
