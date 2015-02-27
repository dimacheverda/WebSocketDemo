//
//  ViewController.swift
//  WebSocketDemo
//
//  Created by Dima Cheverda on 2/26/15.
//  Copyright (c) 2015 Dima Cheverda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var textField: UITextField!
  @IBOutlet weak var tableView: UITableView!
  
  
  var socket: SRWebSocket!
  var chatManager: ChatManager!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let url = NSURL(string: "ws://localhost/api/v1/ws")!
    chatManager = ChatManager(url: url)
    
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "messageRecieved", name: "kMessageRecievedNotification", object: nil)
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
  }
  
  @IBAction func sendButtonPressed(sender: UIButton) {
    if textField.text == "" {
      return
    }
    
    let message = ChatMessage(text: textField.text, isMe: true)
    chatManager.sendChatMessage(message)
    
    resetTextField()
  }
  
  func resetTextField() {
    textField.text = ""
  }
  
  func messageRecieved() {
    tableView.reloadData()
  }
  
  
  // MARK: - Keyboard Show/Hide notification
  
  func keyboardWillShow(notification: NSNotification) {
    adjustInsetForKeyboardShow(true, notifcation: notification)
  }
  
  func keyboardWillHide(notification: NSNotification) {
    adjustInsetForKeyboardShow(false, notifcation: notification)
  }
  
  func adjustInsetForKeyboardShow(show: Bool, notifcation: NSNotification) {
    let userInfo = notifcation.userInfo ?? [:]
    let keyboardFrame = (userInfo[UIKeyboardFrameBeginUserInfoKey] as NSValue).CGRectValue()
    let adjustmentHeight = (CGRectGetHeight(keyboardFrame)) * (show ? 1 : -1)
    
    tableView.contentInset.bottom += adjustmentHeight
    tableView.scrollIndicatorInsets.bottom += adjustmentHeight
  }
}

extension ViewController: UITableViewDataSource {
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return chatManager.messages.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cellIdentifier = "MessageCell"
    var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as UITableViewCell
    
    cell.clipsToBounds = false
    
    let currentMessage = chatManager.messages[indexPath.row] as ChatMessage
    
    if currentMessage.isMe == true {
      cell.textLabel?.text = currentMessage.text
      cell.detailTextLabel?.text = ""
    } else {
      cell.detailTextLabel?.text = currentMessage.text
      cell.textLabel?.text = ""
    }
    
    return cell
  }
}
