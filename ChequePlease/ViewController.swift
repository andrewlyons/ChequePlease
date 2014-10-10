//
//  ViewController.swift
//  ChequePlease
//
//  Created by Andrew Lyons on 07 Oct 14.
//  Copyright (c) 2014 Andrew Lyons. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    var oldAmount = 0.00    // To animate fields as amount is entered.
    
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipText: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var blacklineView: UIView!
    @IBOutlet weak var totalText: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var splitView: UIView!
    @IBOutlet weak var peopleLabel2: UILabel!
    @IBOutlet weak var peopleLabel3: UILabel!
    @IBOutlet weak var peopleLabel4: UILabel!
    @IBOutlet weak var peopleLabel5: UILabel!
    @IBOutlet weak var peopleLabel6: UILabel!
    @IBOutlet weak var peopleLabel7: UILabel!
    @IBOutlet weak var peopleLabel8: UILabel!
    @IBOutlet weak var peopleLabel9: UILabel!
    @IBOutlet weak var peopleLabel10: UILabel!
    
    func showFields(value: CGFloat)
    {
        tipText.alpha          = value
        tipLabel.alpha         = value
        blacklineView.alpha    = value
        totalText.alpha        = value
        totalLabel.alpha       = value
        splitView.alpha        = value  // This is the whole split section.
    }

    func slideFields(direction: CGFloat)
    {
        // direction = -1 (up) or +1 (down)
        // This was more reliable than making a relative change to the original positions
        if direction == -1.0
        {
            tipLabel.frame.origin.y = 155
            tipText.frame.origin.y = 155
            blacklineView.frame.origin.y = 190
            totalLabel.frame.origin.y = 210
            totalText.frame.origin.y = 210
        } else {
            tipLabel.frame.origin.y = 160
            tipText.frame.origin.y = 160
            blacklineView.frame.origin.y = 200
            totalLabel.frame.origin.y = 230
            totalText.frame.origin.y = 230
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setNeedsStatusBarAppearanceUpdate()
        
        tipLabel.text   = "$0.00"
        totalLabel.text = "$0.00"
        billField.layer.borderColor = tipText.textColor.CGColor
        // Must do these for color to stick:
        billField.layer.borderWidth = 1.0
        billField.layer.cornerRadius = 4.0
        billField.layer.masksToBounds = true
    }
    
    override func viewWillAppear(animated: Bool)
    {
        // Hide labels that animate in later:
        showFields(0)
        slideFields(-1.0)
    }
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        billField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle
    {
        return UIStatusBarStyle.LightContent
    }
    
    @IBAction func onTap(sender: AnyObject)
    {
        view.endEditing(true)
    }

    @IBAction func onEditingChanged(sender: AnyObject)
    {
        var tipPercentages = [0.15, 0.2, 0.3]
        var tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        
        var billAmount = NSString(string: billField.text).doubleValue
        var tip   = billAmount * tipPercentage
        var total = billAmount + tip
        
        tipLabel.text   = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
        peopleLabel2.text = String(format: "$%.2f", total/2)
        peopleLabel3.text = String(format: "$%.2f", total/3)
        peopleLabel4.text = String(format: "$%.2f", total/4)
        peopleLabel5.text = String(format: "$%.2f", total/5)
        peopleLabel6.text = String(format: "$%.2f", total/6)
        peopleLabel7.text = String(format: "$%.2f", total/7)
        peopleLabel8.text = String(format: "$%.2f", total/8)
        peopleLabel9.text = String(format: "$%.2f", total/9)
        peopleLabel10.text = String(format: "$%.2f", total/10)
        
        // Animation! Fun!
        var wasZero = (oldAmount  < 0.01)   // Old amount was zero.
        var nowZero = (billAmount < 0.01)   // New amount is zero.
        
        if wasZero && !nowZero
        {
            // Animate in:
            self.showFields(0)
            self.slideFields(-1.0)
            UIView.animateWithDuration(0.4, animations:
            {
                self.showFields(1)
                self.slideFields(1.0)
            })
        }
        else if nowZero && !wasZero
        {
            // Animate out:
            self.showFields(1)
            self.slideFields(1.0)
            UIView.animateWithDuration(0.4, animations:
            {
                self.showFields(0)
                self.slideFields(-1.0)
            })
        }
 
        oldAmount = billAmount  // Remember for next time.
    }
}