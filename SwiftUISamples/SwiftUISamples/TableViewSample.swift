//
//  TableViewSample.swift
//  SwiftUISamples
//
//  Created by Roger Yee on 5/7/15.
//  Copyright (c) 2015 Roger Yee. All rights reserved.
//

import UIKit

class TableViewSample: SampleView, ChatDataSource {
    
    var chats : [Message]!
    var tableView : TableView!
    var sendView : UIView!
    
    override func loadView() {
        
        self.loadChatData()
        self.tableView = TableView(frame:CGRectMake(0, 20, self.frame.size.width, self.frame.size.height - 20))
        self.tableView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.tableView!.registerClass(TableViewCell.self, forCellReuseIdentifier: "MsgCell")
        self.tableView.chatDataSource = self
        self.tableView.reloadData()
        self.addSubview(self.tableView)
        
        self.sendView = SendView()
        self.sendView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.addSubview(self.sendView)
        
        // Add Constraints
        var views = ["tableView": self.tableView,"sendView":self.sendView]
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[tableView]|", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views));
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[sendView]|", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views));
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-70-[tableView]-[sendView(==50)]|", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views));
        
        // Scroll to Bottom
        var index = NSIndexPath(forRow: self.tableView.numberOfRowsInSection(0)-1, inSection: 0)
        self.tableView.scrollToRowAtIndexPath(index, atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
    }
    
    func loadChatData() {
        var me = "xiaoming.png"
        var you = "xiaohua.png"
        
        var first =  Message(body:"嘿，这张照片咋样，我在泸沽湖拍的呢！", logo:me,  date:NSDate(timeIntervalSinceNow:-600), mtype:ChatType.Mine)
        var second =  Message(image:UIImage(named:"luguhu.jpeg")!,logo:me, date:NSDate(timeIntervalSinceNow:-290), mtype:ChatType.Mine)
        var third =  Message(body:"太赞了，我也想去那看看呢！",logo:you, date:NSDate(timeIntervalSinceNow:-60), mtype:ChatType.Other)
        var fouth =  Message(body:"嗯，下次我们一起去吧！",logo:me, date:NSDate(timeIntervalSinceNow:-20), mtype:ChatType.Mine)
        var fifth =  Message(body:"好的，一定！",logo:you, date:NSDate(timeIntervalSinceNow:0), mtype:ChatType.Other)
        
        chats = [first,second, third, fouth, fifth]
    }
    
    func rowsForChatTable(tableView:TableView) -> Int
    {
        return self.chats.count
    }
    
    func chatTableView(tableView:TableView, dataForRow row:Int) -> Message
    {
        return self.chats[row]
    }
}

class SendView:UIView, UITextFieldDelegate {
    var msgTextField : UITextField!
    var senderBtn : UIButton!
    
    override init(frame aRect: CGRect) {
        super.init(frame: aRect)
        
        self.backgroundColor = UIColor.blueColor()
        self.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        msgTextField = UITextField()
        msgTextField.backgroundColor = UIColor.whiteColor()
        msgTextField.textColor=UIColor.blackColor()
        msgTextField.font=UIFont.boldSystemFontOfSize(12)
        msgTextField.layer.cornerRadius = 10.0
        msgTextField.returnKeyType = UIReturnKeyType.Send
        msgTextField.delegate=self
        msgTextField.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.addSubview(msgTextField)

        senderBtn = UIButton()
        senderBtn.backgroundColor=UIColor.lightGrayColor()
        senderBtn.addTarget(self, action:Selector("sendMessage") ,forControlEvents:UIControlEvents.TouchUpInside)
        senderBtn.layer.cornerRadius=6.0
        senderBtn.setTitle("Send", forState:UIControlState.Normal)
        senderBtn.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.addSubview(senderBtn)
        
        // Add Constraints
        let views = ["msgTextField": msgTextField,"senderBtn":senderBtn]
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[msgTextField]-[senderBtn(==50)]-|", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views));
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[msgTextField]-|", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views));
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[senderBtn]-|", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views));
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder : aDecoder)
    }
    
    func textFieldShouldReturn(textField:UITextField) -> Bool
    {
        sendMessage()
        return true
    }
    
    func sendMessage()
    {
//        //composing=false
//        var sender = txtMsg
//        
//        var thisChat =  MessageItem(body:sender.text, user:me, date:NSDate(), mtype:ChatType.Mine)
//        
//        var thatChat =  MessageItem(body:"你说的是：\(sender.text)!", user:you, date:NSDate(), mtype:ChatType.Someone)
//        
//        Chats.addObject(thisChat)
//        Chats.addObject(thatChat)
//        self.tableView.chatDataSource = self
//        self.tableView.reloadData()
//        
//        //self.showTableView()
//        sender.resignFirstResponder()
//        sender.text = ""
    }
}

class TableView:UITableView, UITableViewDelegate, UITableViewDataSource {
    var bubbleSection:Array<Message>!
    var chatDataSource:ChatDataSource!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame:CGRect)
    {
        super.init(frame:frame,  style:UITableViewStyle.Grouped)
        
        self.backgroundColor = UIColor.clearColor()
        self.separatorStyle = UITableViewCellSeparatorStyle.None
//        self.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
//        self.layer.borderWidth = 1
//        self.layer.borderColor = UIColor.blackColor().CGColor
        self.bubbleSection = Array<Message>()
        self.delegate = self
        self.dataSource = self
        
        println("init tableview")
    }
    
    //按日期排序方法
    func sortDate(m1: Message, m2: Message) -> Bool {
        return m1.date.timeIntervalSince1970 < m2.date.timeIntervalSince1970
    }
    
    override func reloadData()
    {
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        
        var count =  0
        if ((self.chatDataSource != nil))
        {
            count = self.chatDataSource.rowsForChatTable(self)
            
            if(count > 0)
            {
                for (var i = 0; i < count; i++)
                {
                    var object =  self.chatDataSource.chatTableView(self, dataForRow:i)
                    bubbleSection.append(object)
                }
                bubbleSection.sort({ $0.date.timeIntervalSince1970 > $1.date.timeIntervalSince1970 })
            }
        }
        super.reloadData()
        println("reloadData")
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.bubbleSection.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if (indexPath.row == 0){
            return 30.0
        }
        
        var data =  self.bubbleSection[indexPath.row - 1]
        
        return max(data.insets.top + data.view.frame.size.height + data.insets.bottom + 5, 50+5)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cellId = "MsgCell"
        if(indexPath.row > 0) {
            var data =  self.bubbleSection[indexPath.row-1]
            
            var cell =  TableViewCell(data:data, reuseIdentifier:cellId)
            
            return cell
        } else {
            return UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellId)
        }
    }
}

class TableViewCell:UITableViewCell {
    var customView:UIView!
    var bubbleImage:UIImageView!
    var logoImage:UIImageView!
    var message:Message!
    
    init(data:Message, reuseIdentifier cellId:String) {
        self.message = data
        super.init(style:UITableViewCellStyle.Default, reuseIdentifier:cellId)
        
        render()
        
        println("init cell")
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func render() {
        self.selectionStyle = UITableViewCellSelectionStyle.None
        
        addLogoImage()
        addBubbleImage()
        addCustomView()
        addConstraints()
    }
    
    func addLogoImage(){
        if(self.message.logo == "") {
            return
        }
        
        self.logoImage = UIImageView(image: UIImage(named:(self.message.logo)))
        self.logoImage.layer.cornerRadius = 9.0
        self.logoImage.layer.masksToBounds = true
        self.logoImage.layer.borderColor = UIColor(white: 0.0, alpha: 0.2).CGColor
        self.logoImage.layer.borderWidth = 1.0
        self.logoImage.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.addSubview(self.logoImage)
    }
    
    func addBubbleImage(){
        self.bubbleImage = UIImageView()
        self.bubbleImage.setTranslatesAutoresizingMaskIntoConstraints(false)
        if (self.message.mtype == ChatType.Other){
            self.bubbleImage.image = UIImage(named:("yoububble.png"))!.stretchableImageWithLeftCapWidth(21,topCapHeight:14)
        }
        else {
            self.bubbleImage.image = UIImage(named:"mebubble.png")!.stretchableImageWithLeftCapWidth(15, topCapHeight:14)
        }
        self.addSubview(self.bubbleImage)
    }
    
    func addCustomView(){
        self.customView = self.message.view
        self.customView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.addSubview(self.customView)
    }
    
    func addConstraints(){
        
        let views = ["bubbleImage":bubbleImage, "logoImage": self.logoImage, "customView":self.customView]
        let metrics = [
            "logoImageWidth":50,
            "logoImageHeight":50,
            "bubbleImageWidth":self.message.insets.left + self.message.view.frame.size.width + self.message.insets.right,
            "bubbleImageHeight":self.message.insets.top + self.message.view.frame.size.height + self.message.insets.bottom,
            "customViewWidth":self.message.view.frame.size.width,
            "customViewHeight":self.message.view.frame.size.height,
            "customViewTopOffset":self.message.insets.top,
            "customViewRightOffset":self.message.insets.right + 5,
            "customViewLeftOffset":self.message.insets.left + 5,
        ]
        
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[logoImage(==logoImageWidth)]", options: NSLayoutFormatOptions.allZeros, metrics: metrics, views: views));
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[logoImage(==logoImageHeight)]", options: NSLayoutFormatOptions.allZeros, metrics: metrics, views: views));
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[bubbleImage(==bubbleImageWidth)]", options: NSLayoutFormatOptions.allZeros, metrics: metrics, views: views));
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[bubbleImage(==bubbleImageHeight)]", options: NSLayoutFormatOptions.allZeros, metrics: metrics, views: views));
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[customView(==customViewWidth)]", options: NSLayoutFormatOptions.allZeros, metrics: metrics, views: views));
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[customView(==customViewHeight)]", options: NSLayoutFormatOptions.allZeros, metrics: metrics, views: views));
        
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[logoImage]|", options: NSLayoutFormatOptions.allZeros, metrics: metrics, views: views));
        
        var constraint = (self.message.mtype == ChatType.Mine ? "H:[bubbleImage]-5-[logoImage]-5-|" : "H:|-5-[logoImage]-5-[bubbleImage]")
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(constraint, options: NSLayoutFormatOptions.allZeros, metrics: metrics, views: views));
        
        constraint = (self.message.mtype == ChatType.Mine ? "H:[customView]-customViewRightOffset-[logoImage]" : "H:[logoImage]-customViewLeftOffset-[customView]")
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(constraint, options: NSLayoutFormatOptions.allZeros, metrics: metrics, views: views));
        
        constraint = "V:|-customViewTopOffset-[customView]"
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(constraint, options: NSLayoutFormatOptions.allZeros, metrics: metrics, views: views));
    }
}

protocol ChatDataSource
{
    /*返回对话记录中的全部行数*/
    func rowsForChatTable( tableView:TableView) -> Int
    
    /*返回某一行的内容*/
    func chatTableView(tableView:TableView, dataForRow:Int)-> Message
    
}

enum ChatType {
    case Mine
    case Other
}

class Message {
    
    var logo:String
    var date:NSDate
    var mtype:ChatType
    var view:UIView
    var insets:UIEdgeInsets
    
    class func getTextInsetsMine() -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 10, bottom: 11, right: 17)
    }
    
    class func getTextInsetOthers() -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 15, bottom: 11, right: 10)
    }
    
    class func getImageInsetMine() -> UIEdgeInsets {
        return UIEdgeInsets(top: 11, left: 13, bottom: 16, right: 22)
    }
    
    class func getImageInsetOthers() -> UIEdgeInsets {
        return UIEdgeInsets(top: 11, left: 13, bottom: 16, right: 22)
    }
    
    init(logo:String, date:NSDate, mtype:ChatType, view:UIView, insets:UIEdgeInsets) {
        self.view = view
        self.logo = logo
        self.date = date
        self.mtype = mtype
        self.insets = insets
    }
    
    convenience init(body:NSString, logo:String, date:NSDate, mtype:ChatType) {
        var font = UIFont.boldSystemFontOfSize(12)
        var width = 225, height = 10000.0
        
        var atts = NSMutableDictionary()
        atts.setObject(font, forKey: NSFontAttributeName)
        
        var size = body.boundingRectWithSize(CGSizeMake(CGFloat(width), CGFloat(height)), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: atts as [NSObject : AnyObject], context: nil)
        
        var label = UILabel(frame:CGRectMake(0, 0, size.size.width, size.size.height))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.ByWordWrapping
        label.text = (body.length == 0 ? "" : body as String)
        label.font = font
        label.backgroundColor = UIColor.clearColor()
        
        var insets:UIEdgeInsets = (mtype == ChatType.Mine ? Message.getTextInsetsMine() : Message.getTextInsetOthers())
        
        self.init(logo:logo, date:date, mtype:mtype, view:label, insets:insets)
    }
    
    convenience init(image:UIImage, logo:String, date:NSDate, mtype:ChatType) {
        var size = image.size
        
        if(size.width>220) {
            size.width = 220
            size.height /= (size.width / 220)
        }
        
        var imageView = UIImageView(frame:CGRectMake(0, 0, size.width, size.height))
        imageView.image = image
        imageView.layer.cornerRadius = 5.0
        imageView.layer.masksToBounds = true
        
        var insets:UIEdgeInsets = (mtype == ChatType.Mine ? Message.getImageInsetMine() : Message.getImageInsetOthers())
        
        self.init(logo:logo, date:date, mtype:mtype, view:imageView, insets:insets)
    }
}











