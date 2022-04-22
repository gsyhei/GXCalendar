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
//        for item in model.dayList {
//            let week = item.components.weekday ?? 0
//            let string = GXCalendar.gx_stringDate(item.date, format: "yyyy-MM-dd")
//
//            NSLog("\(string): week: \(week)")
//        }
        
//        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 100, width: 300, height: 400))
//        self.view.addSubview(datePicker)
        let rect = CGRect(x: 0, y: 100, width: UIScreen.main.bounds.width, height: 400)
        let layout = UICollectionViewFlowLayout()
        var vcs: [UIViewController] = []
        for _ in 0...10 {
            let vc = UIViewController()
            let collectionView = GXCalendarCollectionView(frame: rect, collectionViewLayout: layout)
            collectionView.model = model
            vc.view.addSubview(collectionView)
            vcs.append(vc)
        }
            
        
        let pageVC = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        pageVC.dataSource = self
        pageVC.delegate = self
        self.addChild(pageVC)
        self.view.addSubview(pageVC.view)
        pageVC.setViewControllers([vcs.first!], direction: .forward, animated: true)
    }

}

extension ViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        let model = GXCalendarMonthModel(year: 2022, month: 2)
        let rect = CGRect(x: 0, y: 100, width: UIScreen.main.bounds.width, height: 400)
        let layout = UICollectionViewFlowLayout()
        let vc = UIViewController()
        let collectionView = GXCalendarCollectionView(frame: rect, collectionViewLayout: layout)
        collectionView.model = model
        vc.view.addSubview(collectionView)
        
        
        return vc
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let model = GXCalendarMonthModel(year: 2021, month: 12)
        let rect = CGRect(x: 0, y: 100, width: UIScreen.main.bounds.width, height: 400)
        let layout = UICollectionViewFlowLayout()
        let vc = UIViewController()
        let collectionView = GXCalendarCollectionView(frame: rect, collectionViewLayout: layout)
        collectionView.model = model
        vc.view.addSubview(collectionView)
        
        return vc
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {

    }
}

