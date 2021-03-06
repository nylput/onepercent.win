//
//  DateSelectionCell.swift
//  OnePercentWin
//
//  Created by David on 3/3/19.
//  Copyright © 2019 David Lam. All rights reserved.
//

import UIKit

class DateSelectionCell: UICollectionViewCell {
    @IBOutlet private weak var dayLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var monthLabel: UILabel!
    @IBOutlet private weak var accessoryView: UIView!
    
    var cellModel: DateSelectionCellModelling! {
        didSet {
            dayLabel.text = cellModel.dayString
            dateLabel.text = cellModel.dateString
            monthLabel.text = cellModel.monthString
            if accessoryView.backgroundColor == nil && accessoryView.backgroundColor != cellModel.colorForAccessory {
                accessoryView.backgroundColor = cellModel?.colorForAccessory
            }
            configureFor(selected: isSelected)
        }
    }
    
    override var isSelected: Bool {
        didSet {
            configureFor(selected: isSelected)
        }
    }
    
    func configureFor(selected: Bool) {
        if selected {
            if backgroundColor != accessoryView.backgroundColor {
                backgroundColor = accessoryView.backgroundColor
            }
            dayLabel.applyFont(fontSize: .extraSmall, color: .black)
            dateLabel.applyFont(fontSize: .small, color: .black)
            monthLabel.applyFont(fontSize: .extraSmall, color: .black)
        } else {
            if backgroundColor != .clear {
                backgroundColor = .clear
            }
            dayLabel.applyFont(fontSize: .extraSmall)
            dateLabel.applyFont(fontSize: .small)
            monthLabel.applyFont(fontSize: .extraSmall)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 5.0
        clipsToBounds = true
    }
    override func awakeFromNib() {
        accessoryView.backgroundColor = cellModel?.colorForAccessory
    }
}
