//
//  TagsView.swift
//  JACom
//
//  Created by HyeounMin Kim on 2016. 12. 20..
//  Modified by Jose Kang on 2017 06.14

//  Copyright © 2016년 중앙일보. All rights reserved.

//

import UIKit

@IBDesignable
class TagsView: XIBCustomView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var collectionViewHeight: NSLayoutConstraint!
    
    private let cellIdentifier = "TagCollectionViewCell"
    private let cellBtnIdentifier = "TagBtnCollectionViewCell"
    
    var typeFunction:((Int) -> Void)?
    
    var selectIndex: IndexPath = IndexPath(row: 0, section: 0)
    var gap: CGFloat = 108  //gap1+gap2 |-gap1-view-gap2-|
    var hideDeleteBtn:Bool = true {
        didSet {
            if hideDeleteBtn == false {
                self.collectionView.register(UINib(nibName: cellBtnIdentifier, bundle: nil),
                                             forCellWithReuseIdentifier: cellBtnIdentifier)
            }
        }
    }
    private var sizes: [CGSize] = []
    var tagsColor: [Bool] = []
    var tags: [String] = [] {
        didSet {

            let sizeWidth = UIScreen.main.bounds.width - gap //cell로드가 안되서 강제로 ㅠㅠ
            var line: CGFloat = 1;
            var width: CGFloat = 0
            sizes = []
            
            tags.forEach { tag in
                var stringSize = self.calculateSize(from: tag)
                stringSize.width = stringSize.width > sizeWidth ? sizeWidth : stringSize.width
                sizes.append( stringSize )
                width += sizes.last!.width
                
                if width > sizeWidth {
                    width = sizes.last!.width
                    line += 1
                    
                }
                
            }
            collectionViewHeight.constant = ((24 + 6) * line) - 6
            
        }
    }
    
    func resetCollectionView(){
        tags = []
        self.collectionView.reloadData()
    }
    
    override var boundsToChild: Bool { return true }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let layout = LeftAlignedCollectionViewFlowLayout()
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        self.collectionView.backgroundColor = self.backgroundColor
        self.collectionView.collectionViewLayout = layout
        self.collectionView.register(UINib(nibName: cellIdentifier, bundle: nil),
                                     forCellWithReuseIdentifier: cellIdentifier)
    }

    // MARK: - UICollectionViewDataSource
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return tags.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if hideDeleteBtn {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! TagCollectionViewCell
            cell.tagLabel.text = tags[indexPath.row]
            if tagsColor.count > indexPath.row{
                cell.backgroundColor = tagsColor[indexPath.row] ? UIColor(rgb:0xf5f5f5) : UIColor.white
            }
            return cell
            
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellBtnIdentifier, for: indexPath) as! TagBtnCollectionViewCell
            cell.tagLabel.text = tags[indexPath.row]
            if tagsColor.count > indexPath.row{
                cell.backgroundColor = tagsColor[indexPath.row] ? UIColor(rgb:0xf5f5f5) : UIColor.white
            }
            return cell
            
        }
        
        
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return sizes[indexPath.row]
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        typeFunction?(indexPath.row)
    }
    
    private func calculateSize(from: String) -> CGSize {
        var size = NSString(string: from).size(attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14)])
        size.width += hideDeleteBtn ? 20 + 5 : 20 + 18 + 5
        size.height = 24
        return size
    }
    
    func removeItem(_ index:IndexPath){
        self.tags.remove(at: index.row)
        self.collectionView.performBatchUpdates({
            self.collectionView.deleteItems(at: [index])
        })
    }
}

