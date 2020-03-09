//
//  replyCell.swift
//  commentsDemo
//
//  Created by pratik on 21/12/19.
//  Copyright © 2019 pratik. All rights reserved.
//

import UIKit

class replyCell: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var msg: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    
    typealias delete = (Bool) -> Void
    var deleted:delete?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(reply:Reply) {
        self.img.image = reply.image
        self.msg.text = reply.msg
        self.lblTime.text = reply.time
        
        self.img.layer.cornerRadius = self.img.bounds.height/2
        self.img.clipsToBounds = true
        self.img.layer.borderWidth = 1
        self.img.layer.borderColor = UIColor.blue.cgColor
    }
    
    @IBAction func onBtnDelete(_ sender: Any) {
        if self.deleted != nil {
            self.deleted!(true)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
