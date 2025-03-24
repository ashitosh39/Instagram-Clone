//
//  PostTblCell.swift
//  Instagram-Clone
//
//  Created by PHN MAC 1 on 23/04/24.
//

import UIKit

class PostTblCell: UITableViewCell {
    var isLike = false
    var isSave = false
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    @IBOutlet weak var postCollection: UICollectionView!{
        didSet{
            postCollection.delegate = self
            postCollection.dataSource = self
            postCollection.register(ImageCollectionCell.nib, forCellWithReuseIdentifier: ImageCollectionCell.id)
        }
    }
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    var images: [UIImage] = []{
        didSet{
            images.shuffle()
            pageControl.currentPage = 0
            pageControl.numberOfPages = images.count
            postCollection.reloadData()
        }
    }
    
  
    @IBOutlet weak var likeButton: UIButton!
    @IBAction func likeButtonClick(_ sender: UIButton) {
       
        isLike.toggle()

           // Set the heart image based on the like state
           likeButton.setImage(UIImage(systemName: isLike ? "heart.fill" : "heart"), for: .normal)
           
           // Optionally, if you want the heart to be red when filled and default when unliked
        likeButton.tintColor = isLike ? .red : .gray// Change the tint color (red when liked, gray when unliked)
       }
        
    
    
//    var isSave = false{
//        didSet{
//            saveButton.imageView?.image = self.isSave ? UIImage(systemName: "bookmark.fill") : .save
//        }
//    }
    @IBOutlet weak var saveButton: UIButton!
    @IBAction func saveButtonClick(_ sender: UIButton) {
        isSave.toggle()
//        saveButton.setImage(UIImage(systemName: isSave ? "bookmark.fill" : "bookmark"), for: .normal)
//        saveButton.tintColor = isSave ? .black : .gray
        
        let imageName = isSave ? "bookmark.fill" : "bookmark"
        saveButton.setImage(UIImage(systemName: imageName), for: .normal)
        
        saveButton.tintColor = isSave ? .black : .gray
    }
    
}

extension PostTblCell: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = postCollection.dequeueReusableCell(withReuseIdentifier: ImageCollectionCell.id, for: indexPath) as? ImageCollectionCell else {
            fatalError()
        }
        cell.isLikeHandler = { self.isLike = true }
        cell.imgView.image = images[indexPath.row]
        return cell
    }
}

extension PostTblCell: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = postCollection.frame.width
        let height = postCollection.frame.height
        return .init(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        pageControl.currentPage = indexPath.row
    }
    
//    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        pageControl.currentPage = indexPath.row
//    }
}


