//
//  ViewController.swift
//  PHPickerController
//
//  Created by Mac on 20/11/23.
//

import UIKit
import PhotosUI

class ViewController: UIViewController {
    @IBOutlet weak var photosCollectionView: UICollectionView!
   var imageArray = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func addPhotoButtonTaped(_ sender: Any) {
        var config = PHPickerConfiguration()
        config.selectionLimit = 3
        
        let phPickerVC = PHPickerViewController(configuration: config)
        phPickerVC.delegate = self
        self.present(phPickerVC, animated: true)
    }
    
}

extension ViewController : PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true)
        for result in results {
            result.itemProvider.loadObject(ofClass: UIImage.self) { object,
                error in
                if let image = object as? UIImage {
                    self.imageArray.append(image)
                }
                DispatchQueue.main.async {
                    self.photosCollectionView.reloadData()
                }
            }
        }
    }
}



extension ViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = photosCollectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCell", for: indexPath) as? PhotosCell
        else {
            return UICollectionViewCell()
        }
        cell.photoImageView.image = imageArray[indexPath.row]
        return cell
    }
    
}


extension ViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.size.width/3-2, height: collectionView.frame.size.height/5-2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        2
    }
}
