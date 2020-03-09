//
//  replyInputCell.swift
//  commentsDemo
//
//  Created by pratik on 21/12/19.
//  Copyright © 2019 pratik. All rights reserved.
//

import UIKit

class replyInputCell: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var txtInput: UITextField!
    @IBOutlet weak var inputContainer: UIView!
    
    typealias input = (String) -> Void
    var replied:input?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func configureCell(reply: Reply) {
        self.img.image = reply.image
        self.txtInput.becomeFirstResponder()
        self.txtInput.delegate = self
    }
    
    override func layoutIfNeeded() {
        self.inputContainer.layer.cornerRadius = self.inputContainer.bounds.height/2
        self.inputContainer.clipsToBounds = true
        self.inputContainer.layer.borderColor = UIColor.gray.cgColor
        self.inputContainer.layer.borderWidth = 1
        self.img.layer.cornerRadius = self.img.bounds.height/2
        self.img.clipsToBounds = true
        self.img.layer.borderWidth = 1
        self.img.layer.borderColor = UIColor.blue.cgColor
    }
    
    @IBAction func editingBegin(_ sender: Any) {
    }
    
    @IBAction func editingEnd(_ sender: Any) {
        if txtInput.text != "" {
            if self.replied != nil {
                self.replied!(self.txtInput.text!)
                self.txtInput.text = ""
            }
        }
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}


extension replyInputCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        txtInput.resignFirstResponder()
        return true
    }
}
