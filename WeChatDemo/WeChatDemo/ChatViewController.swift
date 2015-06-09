//
//  ChatViewController.swift
//  WeChatDemo
//
//  Created by Roger Yee on 5/28/15.
//  Copyright (c) 2015 Roger Yee. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, MessageDelegate {
    
    var appDelegate : AppDelegate!
    
    var messages : Array<Message>!
    var buddy : Buddy!
    
    var tableView : TableView!
    var sendView : SendView!
    
    init(messages:[Message], buddy : Buddy) {
        super.init(nibName: nil, bundle: nil)
        
        self.messages = messages
        
        self.buddy = buddy
        self.buddy.resetUnreadMessages() // 重置未读信息数
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        self.appDelegate.messageDelegate = self
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.tableView = TableView(frame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height - 20), messages: self.messages)
        self.tableView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.tableView.reloadData()
        self.view.addSubview(self.tableView)
        
        self.sendView = SendView()
        self.sendView.parent = self
        self.sendView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addSubview(self.sendView)
        
        // Add Constraints
        var views = ["tableView": self.tableView,"sendView":self.sendView]
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[tableView]|", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views));
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[sendView]|", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views));
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[tableView]-[sendView(==50)]|", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views));
    }
    
    func sendMessage(message:Message!) {
        
        if message == nil {
            return
        }
        
        var body:DDXMLElement = DDXMLElement.elementWithName("body") as! DDXMLElement
        body.setStringValue((message as! TextMessage).body)
        
        //生成XML消息文档
        var mes:DDXMLElement = DDXMLElement.elementWithName("message") as! DDXMLElement
        
        //消息类型
        mes.addAttributeWithName("type",stringValue:"chat")
        
        //发送给谁
        mes.addAttributeWithName("to" ,stringValue:(self.buddy.name + "@" + (self.appDelegate.xmppStream?.myJID.domain)!))
        
        //由谁发送
        mes.addAttributeWithName("from" ,stringValue:(message.from.name + "@" + (self.appDelegate.xmppStream?.myJID.domain)!))
        
        //组合
        mes.addChild(body)
        
        //发送消息
        self.appDelegate.sendMessage(mes)
        
        tableView.addMessage(message)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func newMessage(message: Message) {
        return
    }
    
    func receiveMessage(message: Message) {
        if buddy == nil {
            return
        }
        
        if buddy.name == message.from.name {
            self.tableView.addMessage(message)
        }
    }
}

class SendView:UIView, UITextFieldDelegate {
    var parent:ChatViewController!
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
        var msg = TextMessage()
        msg.body = self.msgTextField.text
        msg.from = User(name: (parent.appDelegate.xmppStream?.myJID.user)!)
        msg.isDelay = false
        msg.isComposing = false
        msg.isFromMe = true
        
        parent.sendMessage(msg)
        
        self.msgTextField.resignFirstResponder()
        self.msgTextField.text = ""
    }
}

class TableView:UITableView, UITableViewDelegate, UITableViewDataSource {
    
    var allMessages : Array<Message>!
    var groupedMessages : Array<NSMutableArray>!
    let MSG_CELL_ID : String = "MsgCell"
    let HEADER_CELL_ID : String = "HeaderCell"
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(frame:CGRect, messages : Array<Message>)
    {
        super.init(frame:frame,  style:UITableViewStyle.Grouped)
        
        self.backgroundColor = UIColor.clearColor()
        self.separatorStyle = UITableViewCellSeparatorStyle.None
        
        self.delegate = self
        self.dataSource = self
        self.allMessages = messages
    }
    
    func addMessage(message:Message) {
        self.allMessages.append(message)
        reloadData()
    }
    
    func sortByDate(m1: Message, m2: Message) -> Bool {
        return m1.date.timeIntervalSince1970 < m2.date.timeIntervalSince1970
    }
    
    override func reloadData()
    {
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        
        if self.allMessages.count <= 0 {
            return
        }
        
        // Sort and Group
        self.groupedMessages = Array<NSMutableArray>()
        self.allMessages.sort(sortByDate)
        
        var dformatter = NSDateFormatter()
        dformatter.dateFormat = "yyyy年MM月dd日"
        
        var last =  ""
        var currentSection = NSMutableArray()
        for (var i = 0; i < allMessages.count; i++) {
            
            var msg =  allMessages[i]
            var datestr = dformatter.stringFromDate(msg.date)
            if (datestr != last) {
                currentSection = NSMutableArray()
                self.groupedMessages.append(currentSection)
            }
            currentSection.addObject(msg)
            last = datestr
        }
        
        super.reloadData()
        
        // Scroll to Bottom
        var section = self.groupedMessages.count - 1
        var rowIndex = self.numberOfRowsInSection(section) - 1
        var index = NSIndexPath(forRow: rowIndex, inSection: section)
        self.scrollToRowAtIndexPath(index, atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if self.groupedMessages == nil {
            return 0
        }
        var count = self.groupedMessages.count
        return count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = self.groupedMessages[section].count
        return count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        var section : AnyObject  =  self.groupedMessages[indexPath.section]
//        var data = section[indexPath.row] as! Message
//        return max(data.insets.top + data.view.frame.size.height + data.insets.bottom + 5, 50+5)
        return 55.0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var section : AnyObject  =  self.groupedMessages[indexPath.section]
        var data = section[indexPath.row] as! Message
        var cell = TableViewCell(reuseIdentifier:MSG_CELL_ID)
        cell.render(section[indexPath.row] as! Message)
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var section : AnyObject  =  self.groupedMessages[section]
        var data = section[0] as! Message
        
        var dateFormatter =  NSDateFormatter()
        dateFormatter.dateFormat = "yyyy年MM月dd日"
        return dateFormatter.stringFromDate(data.date)
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var section : AnyObject  =  self.groupedMessages[section]
        var data = section[0] as! Message
        var header = TableViewHeaderCell(reuseIdentifier: HEADER_CELL_ID)
        header.setDate(data.date)
        return header
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return TableViewHeaderCell.getHeight()
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
        self.selectionStyle = UITableViewCellSelectionStyle.None
    }
    
    class func getHeight() -> CGFloat
    {
        return 30.0
    }
    
    func setDate(date:NSDate)
    {
        var dateFormatter =  NSDateFormatter()
        dateFormatter.dateFormat = "yyyy年MM月dd日"
        var text =  dateFormatter.stringFromDate(date)
        
        if (self.label != nil)
        {
            self.label.text = text
            return
        }
        
        self.label = UILabel(frame:CGRectMake(0, 0, 300, 30))
        self.label.text = text
        self.label.font = UIFont.boldSystemFontOfSize(12)
        self.label.textAlignment = NSTextAlignment.Center
        self.label.textColor = UIColor.whiteColor()
        self.label.backgroundColor = UIColor.groupTableViewBackgroundColor()
        self.label.layer.cornerRadius = 5
        self.label.layer.masksToBounds = true
        self.label.sizeToFit()
        self.label.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.addSubview(self.label)
        
        let views = ["label":self.label]
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-5-[label]-5-|", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views));
        self.addConstraints([NSLayoutConstraint(item: label, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0.0)])
    }
}

class TableViewCell:UITableViewCell {
    var customView:UIView!
    var bubbleImage:UIImageView!
    var logoImage:UIImageView!
    var messageView:MessageView!
    
    init(reuseIdentifier cellId:String)
    {
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier:cellId)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func render(message : Message) {
        self.selectionStyle = UITableViewCellSelectionStyle.None
        
        var type = message.isFromMe ? ChatType.Mine : ChatType.Other
        self.messageView = TextMessageView(messageBody: (message as! TextMessage).body, sender: message.from, date: message.date, type: type)
        
        addLogoImage()
        addBubbleImage()
        addCustomView()
        addConstraints()
    }
    
    func addLogoImage(){
        if(self.messageView.sender.logo == "") {
            return
        }
        
        self.logoImage = UIImageView(image: UIImage(named:(self.messageView.sender.logo)))
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
        if (self.messageView.type == ChatType.Other){
            self.bubbleImage.image = UIImage(named:("yoububble.png"))!.stretchableImageWithLeftCapWidth(21,topCapHeight:14)
        }
        else {
            self.bubbleImage.image = UIImage(named:"mebubble.png")!.stretchableImageWithLeftCapWidth(15, topCapHeight:14)
        }
        self.addSubview(self.bubbleImage)
    }
    
    func addCustomView(){
        self.customView = self.messageView.view
        self.customView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.addSubview(self.customView)
    }
    
    func addConstraints(){
        
        let views = ["bubbleImage":bubbleImage, "logoImage": self.logoImage, "customView":self.customView]
        let metrics = [
            "logoImageWidth":50,
            "logoImageHeight":50,
            "bubbleImageWidth":self.messageView.insets.left + self.messageView.view.frame.size.width + self.messageView.insets.right,
            "bubbleImageHeight":self.messageView.insets.top + self.messageView.view.frame.size.height + self.messageView.insets.bottom,
            "customViewWidth":self.messageView.view.frame.size.width+10,
            "customViewHeight":self.messageView.view.frame.size.height,
            "customViewTopOffset":self.messageView.insets.top,
            "customViewRightOffset":self.messageView.insets.right + 5,
            "customViewLeftOffset":self.messageView.insets.left + 5,
        ]
        
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[logoImage(==logoImageWidth)]", options: NSLayoutFormatOptions.allZeros, metrics: metrics, views: views));
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[logoImage(==logoImageHeight)]", options: NSLayoutFormatOptions.allZeros, metrics: metrics, views: views));
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[bubbleImage(==bubbleImageWidth)]", options: NSLayoutFormatOptions.allZeros, metrics: metrics, views: views));
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[bubbleImage(==bubbleImageHeight)]", options: NSLayoutFormatOptions.allZeros, metrics: metrics, views: views));
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[customView(==customViewWidth)]", options: NSLayoutFormatOptions.allZeros, metrics: metrics, views: views));
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[customView(==customViewHeight)]", options: NSLayoutFormatOptions.allZeros, metrics: metrics, views: views));
        
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[logoImage]|", options: NSLayoutFormatOptions.allZeros, metrics: metrics, views: views));
        
        var constraint = (self.messageView.type == ChatType.Mine ? "H:[bubbleImage]-5-[logoImage]-5-|" : "H:|-5-[logoImage]-5-[bubbleImage]")
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(constraint, options: NSLayoutFormatOptions.allZeros, metrics: metrics, views: views));
        
        constraint = (self.messageView.type == ChatType.Mine ? "H:[customView]-customViewRightOffset-[logoImage]" : "H:[logoImage]-customViewLeftOffset-[customView]")
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(constraint, options: NSLayoutFormatOptions.allZeros, metrics: metrics, views: views));
        
        constraint = "V:|-customViewTopOffset-[customView]"
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(constraint, options: NSLayoutFormatOptions.allZeros, metrics: metrics, views: views));
    }
    
    func getHeight() ->CGFloat {
        return max(self.messageView.insets.top + self.messageView.view.frame.size.height + self.messageView.insets.bottom + 5, 50+5)
    }
}

class MessageView {
    
    var sender:User
    var type:ChatType
    var date:NSDate
    
    var view:UIView!
    var insets:UIEdgeInsets!
    
    func getEdgeInsets() -> UIEdgeInsets {
        return insets!
    }
    
    func getView() -> UIView {
        return view!
    }
    
    init(sender:User, date:NSDate, type:ChatType) {
        self.sender = sender
        self.date = date
        self.type = type
//        self.view = getView()
//        self.insets = getEdgeInsets()
    }
}

class TextMessageView : MessageView {
    
    var messageBody : String = ""
    
    convenience init(messageBody:String, sender:User, date:NSDate, type:ChatType) {
        self.init(sender:sender, date:date, type:type)
        self.messageBody = messageBody
        self.view = getView()
        self.insets = getEdgeInsets()
    }
    
    override func getEdgeInsets() -> UIEdgeInsets {
        return (type == ChatType.Mine ? Constants.INSETS_TEXT_MSG_MINE : Constants.INSETS_TEXT_MSG_OTHER)
    }
    
    override func getView() -> UIView {
        var font = UIFont.boldSystemFontOfSize(12)
        var width = 225, height = 10000.0
        
        var atts = NSMutableDictionary()
        atts.setObject(font, forKey: NSFontAttributeName)
        
        var size = messageBody.boundingRectWithSize(CGSizeMake(CGFloat(width), CGFloat(height)), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: atts as [NSObject : AnyObject], context: nil)
        
        var label = UILabel(frame:CGRectMake(0, 0, size.size.width, size.size.height))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.ByWordWrapping
        label.text = self.messageBody
        label.font = font
        label.backgroundColor = UIColor.clearColor()
        
        return label
    }
}

class ImageMessageView : MessageView {
    var imageName : String = ""
    
    convenience init(imageName:String, sender:User, date:NSDate, type:ChatType) {
        self.init(sender: sender, date: date, type: type)
        self.imageName = imageName
        self.view = getView()
        self.insets = getEdgeInsets()
    }
    
    override func getEdgeInsets() -> UIEdgeInsets {
        return (type == ChatType.Mine ? Constants.INSETS_IMAGE_MSG_MINE : Constants.INSETS_IMAGE_MSG_OTHER)
    }
    
    override func getView() -> UIView {
        var image = UIImage(named: self.imageName)
        if image == nil {
            return UIImageView()
        }
        
        var size = image!.size
        
        if(size.width>220) {
            size.width = 220
            size.height /= (size.width / 220)
        }
        
        var imageView = UIImageView(frame:CGRectMake(0, 0, size.width, size.height))
        imageView.image = image
        imageView.layer.cornerRadius = 5.0
        imageView.layer.masksToBounds = true
        
        return imageView
    }
}
