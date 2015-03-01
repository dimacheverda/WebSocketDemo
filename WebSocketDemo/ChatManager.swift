//
//  ChatManager.swift
//  WebSocketDemo
//
//  Created by Dima Cheverda on 2/27/15.
//  Copyright (c) 2015 Dima Cheverda. All rights reserved.
//

class ChatManager: NSObject {

  let url: NSURL
  let webSocket: SRWebSocket
  
  var messages = [ChatMessage]()
  
  init(url: NSURL) {
    self.url = url
    webSocket = SRWebSocket(URL: self.url)
    
    super.init()
    
    webSocket.delegate = self
    
    webSocket.open()
  }

  // MARK: - Messages
  
  func sendChatMessage(chatMessage: ChatMessage) {
    webSocket.send(chatMessage.text)
    messages.append(chatMessage)
  }
  
  func postMessageRecievedNotification(message: AnyObject!) {
    NSNotificationCenter.defaultCenter().postNotificationName("kMessageRecievedNotification", object: nil)
  }
  
  func postWebSocketOpenedNotification() {
    NSNotificationCenter.defaultCenter().postNotificationName("kWebSocketOpenedNotification", object: nil)
  }
}

extension ChatManager: SRWebSocketDelegate {

  func webSocketDidOpen(webSocket: SRWebSocket!) {
    postWebSocketOpenedNotification()
  }

  func webSocket(webSocket: SRWebSocket!, didReceiveMessage message: AnyObject!) {
    if let message = message as? String {
      let chatMessage = ChatMessage(text: message, isMe: false)
      messages.append(chatMessage)
      postMessageRecievedNotification(message)
    }
  }

  func webSocket(webSocket: SRWebSocket!, didFailWithError error: NSError!) {
    println("did fails with error: \(error.description)")
  }

  func webSocket(webSocket: SRWebSocket!, didCloseWithCode code: Int, reason: String!, wasClean: Bool) {
    println("did close")
  }
}