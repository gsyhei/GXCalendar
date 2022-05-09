//
//  GXCalendarCollectionView.swift
//  GXCalendarSample
//
//  Created by Gin on 2022/4/16.
//

import UIKit

public class GXCalendarCollectionView: UICollectionView {
    static var CellID = "dayCell"
    public var model: GXCalendarMonthModel? = GXCalendarMonthModel(year: 2022, month: 1)
    private var startSelected: Bool = false
    
    public override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        self.backgroundColor = .white
        self.register(GXCalendarDayCell.self, forCellWithReuseIdentifier: GXCalendarCollectionView.CellID)
        self.allowsMultipleSelection = true
        self.isScrollEnabled = false
        self.delegate = self;
        self.dataSource = self;
        self.reloadData()
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePanGestureRecognizer(pan:)))
        self.addGestureRecognizer(pan)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handlePanGestureRecognizer(pan: UIPanGestureRecognizer) {
        let point = pan.location(in: self)
        switch pan.state {
        case .began:
            self.handlePanBegin(point: point)
        case .ended:
            self.handlePanEnded(point: point)
        case .changed:
            self.handlePanChanged(point: point)
        default: break
        }
    }
    
    func handlePanBegin(point: CGPoint) {
        guard let indexPath = self.indexPathForItem(at: point) else { return }
        guard let cell = self.cellForItem(at: indexPath) else { return }
        self.startSelected = cell.isSelected
    }
    
    func handlePanEnded(point: CGPoint) {
        self.startSelected = false
    }
    
    func handlePanChanged(point: CGPoint) {
        guard let indexPath = self.indexPathForItem(at: point) else { return }
        guard let model = self.model?.dayList[indexPath.row] else { return }
        guard !model.isCurrentMonthOut else { return }
        
        if self.startSelected {
            self.deselectItem(at: indexPath, animated: true)
        }
        else {
            self.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
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
        let rowCount: Int = 7
        let column = (self.model?.dayList.count ?? 0) / rowCount
        let width = Int(collectionView.frame.width) / rowCount
        let height = Int(collectionView.frame.height) / column
        
        return CGSize(width: width, height: height)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let rowCount: Int = 7
        let column = (self.model?.dayList.count ?? 0) / rowCount
        let width = Int(collectionView.frame.width) / rowCount
        let height = Int(collectionView.frame.height) / column
        let left = collectionView.frame.width - CGFloat(width * rowCount)
        let right = collectionView.frame.height - CGFloat(height * column)
        
        return .init(top: right * 0.5, left: left * 0.5, bottom: right * 0.5, right: left * 0.5)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }
    
    // MARK: - UICollectionViewDelegate
    
    public func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        let model = self.model?.dayList[indexPath.row]
        
        return !(model?.isCurrentMonthOut ?? false)
    }
}


