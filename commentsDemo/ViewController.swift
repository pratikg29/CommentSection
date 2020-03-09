//
//  ViewController.swift
//  commentsDemo
//
//  Created by pratik on 21/12/19.
//  Copyright © 2019 pratik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var txtInput: UITextField!
    @IBOutlet weak var inputContainer: UIView!
    
    var viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialAttributes()
    }
    
    func initialAttributes() {
        self.inputContainer.layer.cornerRadius = self.inputContainer.bounds.height/2
        self.inputContainer.clipsToBounds = true
        self.inputContainer.layer.borderColor = UIColor.gray.cgColor
        self.inputContainer.layer.borderWidth = 1
        self.txtInput.leftViewMode = .always
        
        self.table.sectionHeaderHeight = UITableView.automaticDimension;
        self.table.estimatedSectionHeaderHeight = 116;
        self.table.register(UINib(nibName: "commentHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: commentHeaderView.reuseIdentifier)
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == self.txtInput && textField.text != "" {
            self.viewModel.addComment(text: textField.text!) {
                self.table.insertSections([self.viewModel.commentList.count - 1], with: .bottom)
                textField.text = ""
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.commentList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.viewModel.commentList[section].isExpanded {
//            if viewModel.commentList[section].replies.count > 0 {
//
//            }
            return self.viewModel.commentList[section].replies.count
        }
        else {
            return self.viewModel.commentList[section].replies.count >= 1 ? 1 : 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if viewModel.commentList[indexPath.section].replies[indexPath.row].isInput {
            let cell = tableView.dequeueReusableCell(withIdentifier: "replyInput", for: indexPath) as! replyInputCell
            cell.configureCell(reply: viewModel.commentList[indexPath.section].replies[indexPath.row])
            cell.replied = { text in
                self.viewModel.addReplyOfComment(text: text, indexPath: indexPath) {
                    
                    tableView.reloadSections([indexPath.section], with: .automatic)
                }
            }
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "reply", for: indexPath) as! replyCell
            
            if !(viewModel.commentList[indexPath.section].isExpanded) {
                cell.configureCell(reply: viewModel.commentList[indexPath.section].replies.last!)
            }
            else {
                cell.configureCell(reply: viewModel.commentList[indexPath.section].replies[indexPath.row])
            }
            cell.deleted = { flag in
                self.viewModel.deleteReplyOfComment(indexPath: indexPath) {
                    tableView.reloadSections([indexPath.section], with: .automatic)
                }
            }
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: commentHeaderView.reuseIdentifier) as! commentHeaderView
        header.configure(comment: self.viewModel.commentList[section])
        header.clickActions = { delete, reply, more in
            
            if delete {
                self.viewModel.deleteComment(index: section) {
                    tableView.deleteSections([section], with: .left)
                }
            }
            else if reply {
                self.viewModel.addReplyInputOfComment(section: section) {
                    tableView.reloadSections([section], with: .automatic)
                }
            }
            else if more {
                self.viewModel.expandReplies(section: section) {
                    tableView.reloadSections([section], with: .automatic)
                }
            }
        }
        return header
    }
}



