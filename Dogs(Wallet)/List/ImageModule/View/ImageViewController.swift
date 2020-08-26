//
//  ImageViewController.swift
//  Dogs(Wallet)
//
//  Created by Азизбек on 25.08.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import UIKit
import CenteredCollectionView

class ImageViewController: UIViewController {
    
    let reuseIdentifier = "ImageCell"
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var likeButton: UIButton!
    var presenter: ImagePresenter!
    
    var centeredCollectionViewFlowLayout: CenteredCollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "ImageCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: reuseIdentifier)
        centeredCollectionViewFlowLayout = collectionView.collectionViewLayout as? CenteredCollectionViewFlowLayout
        collectionView.decelerationRate = UIScrollView.DecelerationRate.fast
        
        let availableWidth = collectionView.bounds.inset(by: collectionView.layoutMargins).width
        let availableHight = collectionView.bounds.inset(by: collectionView.layoutMargins).height * 0.65
        centeredCollectionViewFlowLayout.itemSize = CGSize(width: availableWidth, height: availableHight )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = presenter.dogForSave?[0].name.capitalizingFirstLetter()
        self.navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(share)), animated: true)
        let fetchedDogs = CoreDataStack.shared.fetchFavouritesDog()
        guard let dogs = presenter?.dogForSave else { return }
        for (index, dog) in dogs.enumerated() {
            
            for fetched in fetchedDogs  where dog.urls == fetched.url {
                
                presenter?.dogForSave?[index].like = true
                
            }
        }
    }
    
    @objc func share() {
        presenter.share()
    }
    
    @IBAction func likeButton(_ sender: UIButton) {
        
        if sender.isSelected {
            print("Not Liked")
            sender.isSelected = false
            for cell in collectionView.visibleCells {
                guard let indexPath = collectionView.indexPath(for: cell), var dog = presenter.dogForSave?[indexPath.row] else { return }
                presenter.dogForSave?[indexPath.row].like = false
                dog.like = false
                CoreDataStack.shared.delete(dog: dog)
            }
        } else {
            print("Like")
            sender.isSelected = true
            for cell in collectionView.visibleCells {
                guard let indexPath = collectionView.indexPath(for: cell), var dog = presenter.dogForSave?[indexPath.row] else { return }
                dog.like = true
                presenter.dogForSave?[indexPath.row].like = true
                CoreDataStack.shared.saveFavouritesDogs(favouriteDog: dog)
            }
        }
    }
}
