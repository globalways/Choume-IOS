//
//  CMTextImageCell.swift
//  Choume
//
//  Created by wang on 16/4/1.
//  Copyright © 2016年 outsouring. All rights reserved.
//

import UIKit

class CMTextImageCell: UITableViewCell{

    @IBOutlet weak var tvIntroduction: UITextView!
    @IBOutlet weak var btnSelectImage: UIButton!
    @IBOutlet weak var cvImageList: UICollectionView!
    
    var delegate: CMNewProjectDetailImagesDelegate?
    //images that has been selected
    var selectImages: [UIImage] = []
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cvImageList.registerNib(UINib(nibName: MainStoryboard.NibIdentifiers.cmCVImageCell, bundle: nil), forCellWithReuseIdentifier: MainStoryboard.CellIdentifiers.cmCVImageCell)
        
    }
    
    @IBAction func toSelectImages() {
        delegate?.onToSelectImage(cvImageList)
    }
    
    func setCollectionViewDataSourceDelegate
        <D: protocol<UICollectionViewDataSource, UICollectionViewDelegate>>
        (dataSourceDelegate: D) {
            
            cvImageList.delegate = dataSourceDelegate
            cvImageList.dataSource = dataSourceDelegate
            cvImageList.reloadData()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
