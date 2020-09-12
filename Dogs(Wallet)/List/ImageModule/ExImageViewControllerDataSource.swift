//
//  ExImageViewControllerDataSource.swift
//  Dogs(Wallet)
//
//  Created by Азизбек on 25.08.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import UIKit

extension ImageViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = presenter.dogForSave?.count else { return 0 }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                        for: indexPath) as? ImageCollectionViewCell
        else { return UICollectionViewCell() }
        
        guard let urlImageString  = presenter.dogForSave?[indexPath.row].urls else { return cell }
        guard let url = URL(string: urlImageString) else { return cell }
        presenter.getImage( url: url, cellImage: cell.imageView)
        
        return cell
    }
    //update like button position
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let willDisplayDog = presenter.dogForSave?[indexPath.row] else { return }
        if  willDisplayDog.like {
            likeButton.isSelected = true
        } else {
            likeButton.isSelected = false
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        for cell in collectionView.visibleCells {
            guard let indexPath = collectionView.indexPath(for: cell) else { return }
            guard let willDisplayDog = presenter.dogForSave?[indexPath.row] else { return }
            if  willDisplayDog.like {
                likeButton.isSelected = true
            } else {
                likeButton.isSelected = false
            }
        }
    }
}
