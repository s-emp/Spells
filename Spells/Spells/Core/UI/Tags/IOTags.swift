//
//  BaseLabelCollectionView.swift
//  instore-osago
//
//  Created by Сергей Мельников on 25.10.2018.
//  Copyright © 2018 SL-Tech. All rights reserved.
//

import UIKit

protocol IOTagsDataSource: AnyObject {
    func components(_ tags: IOTags) -> [CustomStringConvertible]
    func didSelectedItem(_ index: IndexPath)
    func didDeselectedItem(_ index: IndexPath)
}

/// Элемент для расположения тегов в таблице.
/// Для настройки:
///  1. Реализуйте протокол *IOTagsDataSource*
///  2. Проставить protocolDelegate
///  3. В методе viewDidAppear - вызвать prepareSpacingBeetwenCells, reloadData и проставить высоту для растягивающего констрейнта: [IOTags].collectionViewLayout.collectionViewContentSize.height
final class IOTags: UICollectionView {

    weak var protocolDataSource: IOTagsDataSource?
    private(set) var correctDataSource: [String] = []
    private var widthCells: [CGFloat] = []
    private var tapEngine = UISelectionFeedbackGenerator()
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        prepare()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepare()
    }
    
    func prepareSpacingBeetwenCells(_ width: CGFloat) {
        guard let collection = protocolDataSource?.components(self) else { return }
        widthCells = []
        let label = Text()
        var currentWidth: CGFloat = 0.0
        var result: [String] = []
        for (_, item) in collection.enumerated() {
            label.text = item.description
            let newWidth = label.intrinsicContentSize.width + 32
            // Если помещается с расстоянием между ячейкой
            if width >= currentWidth + newWidth + 8 {
                currentWidth += newWidth + 8
                result.append(item.description)
                widthCells.append(newWidth)
            } else if width == currentWidth + newWidth { // Если можно запихнуть тютелька в тютильку
                currentWidth = 0.0
                result.append(item.description)
                widthCells.append(newWidth)
            } else { // если не получается запихнуть
                var viewWidth = width - (currentWidth) - 1
                if viewWidth < 0 { viewWidth = 0 }
                result.append("")
                result.append(item.description)
                widthCells.append(viewWidth)
                widthCells.append(newWidth)
                currentWidth = newWidth + 8
            }
        }
        correctDataSource = result
    }
    
    private func prepare() {
        delegate = self
        dataSource = self
        backgroundColor = .clear
        self.allowsMultipleSelection = true
        register(UINib(nibName: "IOTagCell", bundle: nil), forCellWithReuseIdentifier: "cell")
    }
    
    
}

extension IOTags: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        protocolDataSource?.didSelectedItem(indexPath)
        tapEngine.prepare()
        tapEngine.selectionChanged()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        protocolDataSource?.didDeselectedItem(indexPath)
        tapEngine.prepare()
        tapEngine.selectionChanged()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        updateConstraintsIfNeeded()
        return correctDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let baseCell = cell as? IOTagCell else { fatalError() }
        baseCell.title = correctDataSource[indexPath.row]
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: widthCells[indexPath.row], height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8.0
    }
}

