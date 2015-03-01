//
//  ChatMessage.swift
//  WebSocketDemo
//
//  Created by Dima Cheverda on 2/27/15.
//  Copyright (c) 2015 Dima Cheverda. All rights reserved.
//

class ChatMessage: NSObject, Equatable {
  
  var text: String!
  var isMe: Bool!
  
  init(text: String, isMe: Bool) {
    
    self.text = text
    self.isMe = isMe
    
    super.init()
  }
}

func ==(lhs: ChatMessage, rhs: ChatMessage) -> Bool {
  return
    lhs.text == rhs.text &&
    lhs.isMe == rhs.isMe
}