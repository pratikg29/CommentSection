//
//  commentHeaderView.swift
//  commentsDemo
//
//  Created by pratik on 21/12/19.
//  Copyright © 2019 pratik. All rights reserved.
//

import UIKit

class commentHeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblMsg: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var heightMore: NSLayoutConstraint!
    
    @IBOutlet weak var btnMoreReplies: UIButton!
    
    static let reuseIdentifier = "Header"
    
    typealias click = (_ delete: Bool, _ reply: Bool, _ moreReply: Bool) -> Void
    var clickActions:click?
    
    
    
    func configure(comment: Comment) {
        
        img.image = comment.image
        lblMsg.text = comment.msg
        lblTime.text = comment.time
        self.btnMoreReplies.titleLabel?.text = "Replies"
        if comment.replies.count < 2 {
            self.heightMore.constant = 0
            self.btnMoreReplies.isHidden = true
        }
        else {
            self.heightMore.constant = 30
            self.btnMoreReplies.isHidden = false
        }
        self.layoutIfNeeded()
        self.updateConstraints()
        
        self.img.layer.cornerRadius = self.img.bounds.height/2
        self.img.clipsToBounds = true
        self.img.layer.borderWidth = 1
        self.img.layer.borderColor = UIColor.blue.cgColor
    }
    
    
    @IBAction func onBtnDelete(_ sender: Any) {
        if clickActions != nil {
            clickActions!(true, false, false)
        }
    }
    
    @IBAction func onBtnReply(_ sender: Any) {
        if clickActions != nil {
            clickActions!(false, true, false)
        }
    }
    
    @IBAction func onBtnMoreReplies(_ sender: Any) {
        if clickActions != nil {
            clickActions!(false, false, true)
        }
    }
}
