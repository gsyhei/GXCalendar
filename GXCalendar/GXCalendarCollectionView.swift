//
//  GXCalendarCollectionView.swift
//  GXCalendarSample
//
//  Created by Gin on 2022/4/16.
//

import UIKit

public class GXCalendarCollectionView: UICollectionView {
    static var CellID = "dayCell"
    public var model: GXCalendarMonthModel? = GXCalendarMonthModel(year: 2022, month: 1) {
        didSet {
            self.register(GXCalendarDayCell.self, forCellWithReuseIdentifier: GXCalendarCollectionView.CellID)
            self.delegate = self;
            self.dataSource = self;
            self.reloadData()
        }
    }
}

extension GXCalendarCollectionView: UICollectionViewDataSource {
    // MARK: - UICollectionViewDataSource
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.model?.dayList.count ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GXCalendarCollectionView.CellID, for: indexPath) as! GXCalendarDayCell
        let model = self.model?.dayList[indexPath.row]
        cell.model = model
        
        return cell
    }
}

extension GXCalendarCollectionView: UICollectionViewDelegateFlowLayout {
    // MARK: - UICollectionViewDelegateFlowLayout

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let column = (self.model?.dayList.count ?? 0) / 7
        let height = collectionView.frame.height / CGFloat(column)
        return CGSize(width: collectionView.frame.width / 7.0, height: height)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
}


