//
//  PokemonCell.swift
//  PokeCheck
//
//  Created by Ike Mattice on 8/17/16.
//  Copyright © 2016 Ike Mattice. All rights reserved.
//

import UIKit
//import Gifu


class PokemonCell: UICollectionViewCell {
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var cellCheckLabel: UILabel!
    
    var pokemon: Pokemon?
    let animated = false
    
    
    func configureCell(fromPokemon pokemon: Pokemon) {
//      add the dexNumber to the bottom of the cell
        if let dexNumber = pokemon.dexNumber {
            cellLabel.text = String(describing: dexNumber)
            
            var image = "?"

            if animated {
    //      append the appropriate amount of 0's to the image name
    //        switch Int(dexNumber!) {
    //        case 1...9:
    //            gifName = "00\(dexNumber!)"
    //        case 10...99:
    //            gifName = "0\(dexNumber!)"
    //        case 100...999:
    //            gifName = "\(dexNumber!)"
    //        default:
    //            cellImageView.image = UIImage(named: "1")
    //        }
    //        
    ////      set the label and the image of the cell to the appropriate number and gif
    //        let gif = UIImage(gifName: gifName)
    //            cellImageView.setGifImage(gif, manager: gifManager)
    //        
    ////      get the height and width of the cell and the gif
    //        let gifHeight = cellImageView.currentImage.size.height
    //        let gifWidth = cellImageView.currentImage.size.width
    //        let cellHeight = frame.size.height
    //        let cellWidth = frame.size.width
    //        
    ////      if the gif is larger that the cell, scale the gif down.  Otherwise, display it on the bottom of the cell
    //        if gifHeight > cellHeight || gifWidth > cellWidth {
    //            cellImageView.contentMode = .ScaleAspectFit
    //        } else {
    //            cellImageView.contentMode = .Bottom
    //        }
            } else {
                let pngImage = UIImage(named: String(describing: dexNumber))
                    cellImageView.image = pngImage
                
        //      get the height and width of the cell and the gif
                let gifHeight = cellImageView.image!.size.height
                let gifWidth = cellImageView.image!.size.width
                let cellHeight = frame.size.height
                let cellWidth = frame.size.width
        
        //      if the gif is larger that the cell, scale the gif down.  Otherwise, display it on the bottom of the cell
                if gifHeight > cellHeight || gifWidth > cellWidth {
                    cellImageView.contentMode = .scaleAspectFit
                } else {
                    cellImageView.contentMode = .bottom
                }
            }
        }
        
//      if pokemon has already been caught, apply indicator
        
        
        if pokemon.isCaught == true {
            self.caughtPokemon(withAnimation: false)
        } else {
            self.releasePokemon(withAnimation: false)
        }

    }
    func caughtPokemon(withAnimation animated: Bool) {
        addSubviews(withAnimation: animated)
        //cellImageView.stopAnimatingGif()
        pokemon?.isCaught = true
    }
    func releasePokemon(withAnimation animated: Bool) {
        removeSubviews(withAnimations: animated)
        pokemon?.isCaught = false
        //cellImageView.startAnimatingGif()
    }
    
    func blur(thisImageView imageView: UIImageView, animated: Bool) {
        let blurEffect = UIBlurEffect(style: .extraLight)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
            blurredEffectView.frame = imageView.bounds
            blurredEffectView.alpha = 0.5
            blurredEffectView.tag = 100
                
        imageView.addSubview(blurredEffectView)
    }
    func unblur(thisImageView imageView: UIImageView) {
        if let blur = imageView.viewWithTag(100) {
            blur.removeFromSuperview()
        }
    }
    
    func addPokeBall(toCell cell: PokemonCell, animated: Bool) -> UIView {
//      create a view the same size as the cell
        let containerWidth: CGFloat = 35
        let containerHeight: CGFloat = 35
        
        let imageViewContainerFrame = CGRect(
            x: round((cell.frame.size.width - containerWidth) / 2),
            y: round((cell.frame.size.height - containerHeight) / 2),
            width: containerWidth,
            height: containerHeight
        )
        
//      create a container for image view that can be animated
        let imageViewContainer = UIView(frame: imageViewContainerFrame)
            imageViewContainer.isOpaque = false
            imageViewContainer.tag = 200

//      add an imageView with a pokeball image that fills the container
        let imageView = UIImageView(frame: imageViewContainer.bounds)
            imageView.image = UIImage(named: "PokeBall")
        
//      add subviews to cell and allow user to interact through them
        imageViewContainer.addSubview(imageView)
        cell.addSubview(imageViewContainer)
        cell.isUserInteractionEnabled = true
        
        return imageViewContainer
    }
    func removePokeBall(fromCell cell: PokemonCell, animated: Bool) {
        if let pokeBall = cell.viewWithTag(200) {
            pokeBall.removeFromSuperview()
        }
    }
    func addSubviews(withAnimation animated: Bool) {
        blur(thisImageView: self.cellImageView, animated: animated)
        addPokeBall(toCell: self, animated: animated)
        
        if animated {
            
//          add blur effect
            if let blurView = self.cellImageView.viewWithTag(100) {
                blurView.alpha = 0
                UIView.animate(withDuration: 0.3, animations: {
                    blurView.alpha = 0.5
                })
            }
            
//          add pokeball image
            if let pokeBallImage = self.viewWithTag(200) {
                pokeBallImage.transform = CGAffineTransform(scaleX: 1.6, y: 1.6)
                UIView.animate(withDuration: 0.3, animations: {
                    pokeBallImage.transform = CGAffineTransform.identity
                })
            }
        }
    }
    
//TODO: I dont think this is animating
    func removeSubviews(withAnimations animated: Bool) {
        if animated {
            
//          remove blur effect
            if let blurView = self.cellImageView.viewWithTag(100) {
                blurView.alpha = 0.5
                UIView.animate(withDuration: 0.3, animations: {
                    blurView.alpha = 0
                    blurView.removeFromSuperview()
                })
            }
            
//          remove pokeball image
            if let pokeBallImage = self.viewWithTag(200) {
                pokeBallImage.transform = CGAffineTransform.identity
                pokeBallImage.alpha = 1
                UIView.animate(withDuration: 0.3, animations: {
                    pokeBallImage.transform = CGAffineTransform(scaleX: 1.6, y: 1.6) 
                    pokeBallImage.alpha = 0
                    pokeBallImage.removeFromSuperview()
                })
            }
        }
        unblur(thisImageView: self.cellImageView)
        removePokeBall(fromCell: self, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        //      remove all data user modifications to cell
        cellImageView.image = nil
        cellLabel.text = nil
        removePokeBall(fromCell: self, animated: false)
        unblur(thisImageView: self.cellImageView)
    }
    
    
    
    
    
    
    
//    func desaturate(UIImageView imageView: UIImageView) {
//        //        let scaleFactor = UIScreen.mainScreen().scale
//        //        let extent = CGRect(x: 0, y: 0, width: imageView.frame., height: <#T##CGFloat#>)
//        let ciImage = CIImage(image: imageView.currentImage)
//        let filterColor = CIColor(red: 255/255, green: 1/255, blue: 1/255)
//        
//        print("current Image = \(ciImage)")
//        if let filter = CIFilter(name: "CIColorMonochrome") {
//            
//            filter.setValue(ciImage, forKey: kCIInputImageKey)
//            filter.setValue(filterColor, forKey: kCIInputColorKey)
//            filter.setValue(1, forKey: kCIInputIntensityKey)
//            
//            if let outputImage = filter.outputImage {
//                //        print(filter.outputImage)
//                //        let context = CIContext(options: nil)
//                //        let cgimage = context.createCGImage((filter.outputImage)!, fromRect: (filter.outputImage?.extent)!)
//                //        
//                //        let newImage = UIImage(CGImage: cgimage)
//                let newImage = UIImage(ciImage: outputImage)
//                imageView.image = newImage
//                print("New Image: \(newImage)")
//            } else {
//                print("No output image from monochrome filter")
//            }
//            //        imageView.updateCurrentImage()
//        } else {
//            print("broken monochrome filter")
//        }
//    }
}
