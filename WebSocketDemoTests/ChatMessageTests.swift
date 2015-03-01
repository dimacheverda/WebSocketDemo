//
//  ChatMessageTests.swift
//  WebSocketDemo
//
//  Created by Dima Cheverda on 3/1/15.
//  Copyright (c) 2015 Dima Cheverda. All rights reserved.
//

import UIKit
import XCTest

class ChatMessageTests: XCTestCase {
  
  override func setUp() {
    super.setUp()
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
  func testChatMessageInit() {
    let outcomeMessage = ChatMessage(text: "", isMe: true)
    
    XCTAssertEqual(outcomeMessage.text, "", "Message text is not set correct")
    XCTAssertEqual(outcomeMessage.isMe, true, "Message authority is not set correct")
  }
  
  func testChatMessageEqual() {
    let message1 = ChatMessage(text: "text", isMe: true)
    let message2 = ChatMessage(text: "text", isMe: true)
    
    XCTAssertEqual(message1, message2, "Two messages are not equal")
  }
  
  func testChatMessageNotEqual() {
    let message1 = ChatMessage(text: "text", isMe: true)
    let message2 = ChatMessage(text: "different text", isMe: true)
    
    XCTAssertNotEqual(message1, message2, "Two messages are equal")
  }
}
