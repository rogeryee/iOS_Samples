//
//  ViewController.swift
//  CardScanner
//
//  Created by Roger Yee on 5/27/15.
//  Copyright (c) 2015 Roger Yee. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CardIOPaymentViewControllerDelegate {

    @IBOutlet weak var labelResult: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func scanCard(sender: UIButton) {
        var cardVC = CardIOPaymentViewController(paymentDelegate: self)
        
        cardVC.modalPresentationStyle = UIModalPresentationStyle.FormSheet
        
        self.presentViewController(cardVC, animated: true, completion: nil)
    }
    
    func userDidCancelPaymentViewController(paymentViewController: CardIOPaymentViewController!) {
        self.labelResult.text = "已取消扫描"
        paymentViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func userDidProvideCreditCardInfo(cardInfo: CardIOCreditCardInfo!, inPaymentViewController paymentViewController: CardIOPaymentViewController!) {
        if let info = cardInfo {
            labelResult.text = "卡号:\(info.redactedCardNumber)\n过期时间:\(info.expiryYear)年\(info.expiryMonth)月\n cvv校验: \(info.cvv)"
        }
        paymentViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
}

