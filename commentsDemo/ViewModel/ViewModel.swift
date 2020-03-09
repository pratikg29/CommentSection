//
//  ViewModel.swift
//  commentsDemo
//
//  Created by pratik on 21/12/19.
//  Copyright © 2019 pratik. All rights reserved.
//

import Foundation
import UIKit

class Comment: NSObject {
    var image = UIImage(named: "comment")
    var name = "Jose Julian Sanchez"
    var msg = ""
    var time = ""
    var replies = [Reply]()
    var isExpanded = false
    
    init(msg: String) {
        self.msg = msg
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd 'at' hh:mm a"
        let time = formatter.string(from: date)
        self.time = time
    }
        
    func toggleExpand() {
        if self.isExpanded {
            self.isExpanded = false
        }
        else {
            self.isExpanded = true
        }
    }
}

class Reply: NSObject {
    var image = UIImage(named: "reply")
    var name = "RDJ"
    var msg = ""
    var time = ""
    var isInput = false
    
    init(msg: String) {
        self.msg = msg
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd 'at' hh:mm a"
        let time = formatter.string(from: date)
        self.time = time
    }
}



class ViewModel: NSObject {
    
    var commentList = [Comment]()
    
    override init() {
        super.init()
    }
    
    func deleteComment(index: Int, completion: @escaping () -> Void) {
        self.commentList.remove(at: index)
        completion()
    }
    
    func addComment(text: String, completion: @escaping () -> Void) {
        let comment = Comment(msg: text)
        self.commentList.append(comment)
        completion()
    }
    
    func deleteReplyOfComment(indexPath: IndexPath, completion: @escaping () -> Void) {
        if self.commentList[indexPath.section].isExpanded {
            self.commentList[indexPath.section].replies.remove(at: indexPath.row)
        }
        else {
            self.commentList[indexPath.section].replies.removeLast()
        }
        completion()
    }
    
    func addReplyOfComment(text: String, indexPath: IndexPath, completion: @escaping () -> Void) {
        let reply = Reply(msg: text)
        self.commentList[indexPath.section].replies.removeLast()
        self.commentList[indexPath.section].replies.append(reply)
        completion()
    }
    
    func addReplyInputOfComment(section: Int, completion: @escaping () -> Void) {
        let reply = Reply(msg: "")
        reply.isInput = true
        self.commentList[section].isExpanded = true
        
        if self.commentList[section].replies.last?.isInput ?? false {
            self.commentList[section].replies.removeLast()
        }
        
        self.commentList[section].replies.append(reply)
        completion()
    }
    
    func expandReplies(section: Int, completion: @escaping () -> Void) {
        if self.commentList[section].replies.last?.isInput ?? false {
            self.commentList[section].replies.removeLast()
        }
        self.commentList[section].toggleExpand()
        completion()
    }
}
