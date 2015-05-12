//
//  TableViewSample.swift
//  SwiftUISamples
//
//  Created by Roger Yee on 5/7/15.
//  Copyright (c) 2015 Roger Yee. All rights reserved.
//

import UIKit

class TableViewSample: SampleView {
    
    var chats : NSMutableArray!
    var tableView : TableView!
    var sendView : SendView!
    
    override func loadView() {
        
        self.tableView = TableView(frame:CGRectMake(0, 20, self.frame.size.width, self.frame.size.height - 20))
        self.tableView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.tableView!.registerClass(TableViewCell.self, forCellReuseIdentifier: "MsgCell")
        self.tableView.reloadData()
        self.addSubview(self.tableView)
        
        self.sendView = SendView()
        self.sendView.parent = self
        self.sendView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.addSubview(self.sendView)
        
        // Add Constraints
        var views = ["tableView": self.tableView,"sendView":self.sendView]
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[tableView]|", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views));
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[sendView]|", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views));
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-70-[tableView]-[sendView(==50)]|", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views));
    }
    
    func sendMessage(message:Message) {
        tableView.addMessage(message)
    }
}

class DemoData {
    var data : [Message]!
    init() {
        var me = User(name:"me",logo:"xiaoming.png")
        var you = User(name:"you",logo:"xiaohua.png")
        
        var first =  Message(body:"嘿，这张照片咋样，我在泸沽湖拍的呢！", user:me,  date:NSDate(timeIntervalSinceNow:-6000), mtype:ChatType.Mine)
        var second =  Message(image:UIImage(named:"luguhu.jpeg")!,user:me, date:NSDate(timeIntervalSinceNow:-2900), mtype:ChatType.Mine)
        var third =  Message(body:"太赞了，我也想去那看看呢！",user:you, date:NSDate(timeIntervalSinceNow:-1000), mtype:ChatType.Other)
        var fouth =  Message(body:"嗯，下次我们一起去吧！",user:me, date:NSDate(timeIntervalSinceNow:-200), mtype:ChatType.Mine)
        var fifth =  Message(body:"好的，一定！",user:you, date:NSDate(timeIntervalSinceNow:-10), mtype:ChatType.Other)
        
        data = [first,second, third, fouth, fifth]
//        data = [first]
    }
    
    func getData() -> [Message] {
        return self.data
    }
}

class SendView:UIView, UITextFieldDelegate {
    var parent:TableViewSample!
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
        var sender = self.msgTextField
        
        var me = User(name:"me",logo:"xiaoming.png")
        var you = User(name:"you",logo:"xiaohua.png")
        
        var thisChat =  Message(body:sender.text, user:me, date:NSDate(timeIntervalSinceNow:0), mtype:ChatType.Mine)
        var thatChat =  Message(body:"你说的是：\(sender.text)!", user:you, date:NSDate(timeIntervalSinceNow:10), mtype:ChatType.Other)
        
        parent.sendMessage(thisChat)
        parent.sendMessage(thatChat)
        
        sender.resignFirstResponder()
        sender.text = ""
    }
}

class TableView:UITableView, UITableViewDelegate, UITableViewDataSource {
    
    var allMessages : Array<Message>!
    var groupedMessages : NSMutableArray = NSMutableArray()
    let MSG_CELL_ID : String = "MsgCell"
    let HEADER_CELL_ID : String = "HeaderCell"
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame:CGRect)
    {
        super.init(frame:frame,  style:UITableViewStyle.Grouped)
        
        self.backgroundColor = UIColor.clearColor()
        self.separatorStyle = UITableViewCellSeparatorStyle.None
        
        self.delegate = self
        self.dataSource = self
        
        self.allMessages = DemoData().getData()
    }
    
    func addMessage(message:Message) {
        allMessages.append(message)
        reloadData()
    }
    
    //按日期排序方法
    func sortDate(m1: Message, m2: Message) -> Bool {
        return m1.date.timeIntervalSince1970 < m2.date.timeIntervalSince1970
    }
    
    override func reloadData()
    {
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        
        // 排序并分组
        allMessages.sort(sortDate)
        
        var dformatter = NSDateFormatter()
        dformatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        
        var last =  ""
        var currentSection = NSMutableArray()
        for (var i = 0; i < allMessages.count; i++) {
            
            var msg =  allMessages[i]
            var datestr = dformatter.stringFromDate(msg.date)
            if (datestr != last) {
                currentSection = NSMutableArray()
                self.groupedMessages.addObject(currentSection)
            }
            currentSection.addObject(msg)
            
            last = datestr
        }
        
        super.reloadData()
        
        // Scroll to Bottom
        var index = NSIndexPath(forRow: self.numberOfRowsInSection(0)-1, inSection: self.groupedMessages.count-1)
        self.scrollToRowAtIndexPath(index, atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        var count = self.groupedMessages.count
        
        println("numberOfSectionsInTableView = \(count)")
        
        return count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var count = self.groupedMessages[section].count
        
        println("numberOfRowsInSection = \(count), section = \(section)")
        
        return count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        println("indexPath.section = \(indexPath.section), indexPath.row = \(indexPath.row)")
        
//        if (indexPath.row == 0)
//        {
//            return TableViewHeaderCell.getHeight()
//        }
        
        var section : AnyObject  =  self.groupedMessages[indexPath.section]
        var data = section[indexPath.row] as! Message
        return max(data.insets.top + data.view.frame.size.height + data.insets.bottom + 5, 50+5)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        println("indexPath.section = \(indexPath.section), indexPath.row = \(indexPath.row)")
        
        // Header Cell
//        if (indexPath.row == 0) {
//            var hcell =  TableViewHeaderCell(reuseIdentifier:HEADER_CELL_ID)
//            var section : AnyObject  =  self.groupedMessages[indexPath.section]
//            var data = section[indexPath.row] as! Message
//            
//            hcell.setDate(data.date)
//            return hcell
//        } else {
            var section : AnyObject  =  self.groupedMessages[indexPath.section]
            var data = section[indexPath.row] as! Message
            var cell = TableViewCell(reuseIdentifier:MSG_CELL_ID)
            cell.message = data
            cell.render()
            return cell
//        }
    }
}

class TableViewHeaderCell : UITableViewCell {
    var height:CGFloat = 30.0
    var label:UILabel!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(reuseIdentifier cellId:String)
    {
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier:cellId)
    }
    
    class func getHeight() -> CGFloat
    {
        return 30.0
    }
    
    func setDate(value:NSDate)
    {
        self.height  = 30.0
        var dateFormatter =  NSDateFormatter()
        dateFormatter.dateFormat = "yyyy年MM月dd日"
        var text =  dateFormatter.stringFromDate(value)
        
        if (self.label != nil)
        {
            self.label.text = text
            return
        }
        
        self.selectionStyle = UITableViewCellSelectionStyle.None
        self.label = UILabel()
        self.label.text = text
        self.label.font = UIFont.boldSystemFontOfSize(12)
        self.label.textAlignment = NSTextAlignment.Center
        self.label.shadowOffset = CGSizeMake(0, 1)
        self.label.shadowColor = UIColor.whiteColor()
        self.label.textColor = UIColor.darkGrayColor()
        self.label.backgroundColor = UIColor.clearColor()
        self.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.addSubview(self.label)
        
        let views = ["label":self.label]
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[label]-|", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views));
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[label(==30)]", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views));
    }
}

class TableViewCell:UITableViewCell {
    var customView:UIView!
    var bubbleImage:UIImageView!
    var logoImage:UIImageView!
    var message:Message!
    
    init(reuseIdentifier cellId:String)
    {
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier:cellId)
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
        if(self.message.user.avatar == "") {
            return
        }
        
        self.logoImage = UIImageView(image: UIImage(named:(self.message.user.avatar)))
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
    
    func getHeight() ->CGFloat {
        return max(self.message.insets.top + self.message.view.frame.size.height + self.message.insets.bottom + 5, 50+5)
    }
}


enum ChatType {
    case Mine
    case Other
}

class User{
    var username:String = ""
    var avatar:String = ""
    
    init(name:String, logo:String)
    {
        self.username = name
        self.avatar = logo
    }
}

class Message {
    
    var user:User
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
    
    init(user:User, date:NSDate, mtype:ChatType, view:UIView, insets:UIEdgeInsets) {
        self.view = view
        self.user = user
        self.date = date
        self.mtype = mtype
        self.insets = insets
    }
    
    convenience init(body:NSString, user:User, date:NSDate, mtype:ChatType) {
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
        
        self.init(user:user, date:date, mtype:mtype, view:label, insets:insets)
    }
    
    convenience init(image:UIImage, user:User, date:NSDate, mtype:ChatType) {
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
        
        self.init(user:user, date:date, mtype:mtype, view:imageView, insets:insets)
    }
}











