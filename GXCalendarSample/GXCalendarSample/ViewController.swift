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
        
//        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 100, width: 300, height: 400))
//        self.view.addSubview(datePicker)
        
        let rect = CGRect(x: 0, y: 100, width: UIScreen.main.bounds.width, height: 400)
        let layout = UICollectionViewFlowLayout()
        let collectionView = GXCalendarCollectionView(frame: rect, collectionViewLayout: layout)
        collectionView.model = model
        self.view.addSubview(collectionView)
    }


}

