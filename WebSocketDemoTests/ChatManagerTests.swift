//
//  ChatManagerTests.swift
//  WebSocketDemo
//
//  Created by Dima Cheverda on 3/1/15.
//  Copyright (c) 2015 Dima Cheverda. All rights reserved.
//

import UIKit
import XCTest

class ChatManagerTests: XCTestCase {
  
  var chatManager: ChatManager?
  var expectation: XCTestExpectation?
  let messageRecievedNotificationName = "kMessageRecievedNotification"
  let webSocketOpenedNotificationName = "kWebSocketOpenedNotification"
  
  let correctWebSocketURL = NSURL(string: "ws://localhost/api/v1/ws")
  
  override func setUp() {
    super.setUp()
    
    chatManager = ChatManager(url: correctWebSocketURL!)
    
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "messageRecieved", name: messageRecievedNotificationName, object: nil)
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "webSocketOpened", name: webSocketOpenedNotificationName, object: nil)
  }
  
  override func tearDown() {
    super.tearDown()
    
    chatManager?.webSocket.close()
  }
  
  func testForRecievingCorrectResponseMessage() {
    expectation = self.expectationWithDescription("correct message recieved")
    
    self.waitForExpectationsWithTimeout(3.0, handler: nil)
  }
  
  
  // MARK: - Helper methods
  
  func messageRecieved() {
    if let message = chatManager?.messages.last as ChatMessage? {
      println(message.text)
      if message.text == "Hello! Nice to meet you! Success!" &&
        expectation?.description == "correct message recieved" {
          expectation?.fulfill()
      }
    }
  }
  
  func webSocketOpened() {
    if expectation?.description == "correct message recieved" {
      let outputMessage = ChatMessage(text: "hello", isMe: true)
      chatManager?.sendChatMessage(outputMessage)
    }
  }
  
}