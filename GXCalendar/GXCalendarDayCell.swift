//
//  GXCalendarDayCell.swift
//  GXCalendarSample
//
//  Created by Gin on 2022/4/18.
//

import UIKit

public class GXCalendarDayCell: UICollectionViewCell {
    public enum SelectedType {
        case begin
        case mid
        case end
    }
    public override var isSelected: Bool {
        didSet {
            guard !(self.model?.isMonthOut ?? false) else {
                return
            }
            if self.isSelected {
                self.dayLabel.textColor = .white
                self.chDayLabel.textColor = .white
                self.backgroundColor = .blue
            }
            else {
                self.dayLabel.textColor = .black
                self.chDayLabel.textColor = .darkGray
                self.backgroundColor = .clear
            }
        }
    }
    public var model: GXCalendarDayModel? {
        didSet {
            if let letModel = self.model {
                if letModel.isMonthOut {
                    self.dayLabel.textColor = .lightGray
                    self.chDayLabel.textColor = .lightGray
                }
                else {
                    self.dayLabel.textColor = .black
                    self.chDayLabel.textColor = .darkGray
                }
                self.dayLabel.text = GXCalendar.gx_day(components: letModel.components)
                self.chDayLabel.text = GXCalendar.gx_chineseDay(components: letModel.chComponents)
            }
        }
    }
    public var selectedType: SelectedType? {
        didSet {
            self.setNeedsDisplay()
        }
    }
    public lazy var dayLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.textAlignment = .center
        label.textColor = .blue
        label.font = .boldSystemFont(ofSize: 20)
        
        return label
    }()
    
    public lazy var chDayLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.textAlignment = .center
        label.textColor = .blue
        label.font = .systemFont(ofSize: 14)
        
        return label
    }()
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        var rect = self.bounds
        rect.origin.y = self.bounds.height/2 - 24
        rect.size.height = 24
        self.dayLabel.frame = rect
        
        rect.origin.y = self.bounds.height/2
        rect.size.height = 20
        self.chDayLabel.frame = rect
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(self.dayLabel)
        self.contentView.addSubview(self.chDayLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
