//
//  CMProjectDetailHeaderView.swift
//  Choume
//
//  Created by wang on 16/5/29.
//  Copyright © 2016年 outsouring. All rights reserved.
//

import GSKStretchyHeaderView

class CMProjectDetailHeaderView: GSKStretchyHeaderView {
    let maxFontSize: CGFloat = 40
    let minFontSize: CGFloat = 20
    @IBOutlet weak var labelTest: UILabel!
    
    @available(iOS 9.0, *)
    private lazy var label: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 20, width: self.contentView.width, height: self.contentView.height - 20))
        label.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        label.font = UIFont.monospacedDigitSystemFontOfSize(self.maxFontSize, weight: UIFontWeightMedium)
        label.textColor = UIColor.darkGrayColor()
        label.text = "Scalable text"
        label.textAlignment = .Center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit() {
//        labelTest.autoresizingMask = .FlexibleTopMargin
        if #available(iOS 9.0, *) {
            self.addSubview(self.label)
        } else {
            // Fallback on earlier versions
        }
        
        print(labelTest == nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        labelTest.autoresizingMask = .FlexibleBottomMargin
    }
    
    func loadViewFromNib() -> CMProjectDetailHeaderView {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "CMProjectDetailHeaderView", bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! CMProjectDetailHeaderView
        return view
    }
}
