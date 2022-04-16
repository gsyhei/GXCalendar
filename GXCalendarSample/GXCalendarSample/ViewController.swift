//
//  ViewController.swift
//  GXCalendarSample
//
//  Created by Gin on 2022/4/13.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        let model = GXCalendarMonthModel(year: 2022, month: 1)
        for item in model.dayList {
            let week = item.components.weekday ?? 0
            let string = GXCalendar.gx_stringDate(item.date, format: "yyyy-MM-dd")
            
            NSLog("\(string): week: \(week)")
        }
    }


}

