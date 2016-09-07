//
//  PokemonCell.swift
//  PokeCheck
//
//  Created by Ike Mattice on 8/17/16.
//  Copyright © 2016 Ike Mattice. All rights reserved.
//

import UIKit
import SwiftyGif


class PokemonCell: UICollectionViewCell {
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var cellCheckLabel: UILabel!
    
    let gifManager = SwiftyGifManager(memoryLimit: 50)

    var pokemon: Pokemon?
 
    func configureCell(fromPokemon pokemon: Pokemon) {
//      add the dexNumber to the bottom of the cell
        let dexNumber = pokemon.dexNumber
        cellLabel.text = String(dexNumber!)
        
        var gifName = "?"

//      append the appropriate amount of 0's to the image name
        switch Int(dexNumber!) {
        case 1...9:
            gifName = "00\(dexNumber!)"
        case 10...99:
            gifName = "0\(dexNumber!)"
        case 100...999:
            gifName = "\(dexNumber!)"
        default:
            cellImageView.image = UIImage(named: "1")
        }
        
//      set the label and the image of the cell to the appropriate number and gif
        let gif = UIImage(gifName: gifName)
        cellImageView.setGifImage(gif, manager: gifManager)
        
//      get the height and width of the cell and the gif
        let gifHeight = cellImageView.currentImage.size.height
        let gifWidth = cellImageView.currentImage.size.width
        let cellHeight = frame.size.height
        let cellWidth = frame.size.width
        
//      if the gif is larger that the cell, scale the gif down.  Otherwise, display it on the bottom of the cell
        if gifHeight > cellHeight || gifWidth > cellWidth {
            cellImageView.contentMode = .ScaleAspectFit
        } else {
            cellImageView.contentMode = .Bottom
        }
        
//      if pokemon has already been caught, apply indicator
        if pokemon.isCaught == true {
            caughtPokemon(self, animated: false)
        } else {
            releasePokemon(self, animated: false)
        }

    }
    
    func caughtPokemon(cell: PokemonCell, animated: Bool) {
        blur(thisImageView: cellImageView, animated: animated)
//        addPokeBall(toCell: cell, animated: true)
//        animatePokemball(true, cell: cell, frame: cell.frame, containerWidth: 35, containerHeight: 35)
//        desaturate(UIImageView: cell.cellImageView)
        cellImageView.stopAnimatingGif()
        pokemon?.isCaught = true
//        print("caught!")
    }
    func releasePokemon(cell: PokemonCell, animated: Bool) {
        removePokeBall(fromCell: cell, animated: animated)
        pokemon?.isCaught = false
        cellImageView.startAnimatingGif()
        unblur(thisImageView: cellImageView)
//        print("uncaught!")
    }
    
    func blur(thisImageView imageView: UIImageView, animated: Bool) {
        let blurEffect = UIBlurEffect(style: .ExtraLight)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.frame = imageView.bounds
        blurredEffectView.alpha = 0.5
        
//      add fade in effect
        if animated {
            alpha = 0
            UIView.animateWithDuration(0.3, animations: {
                self.alpha = 0.9
            })
        }
        
        imageView.addSubview(blurredEffectView)
    }
    func unblur(thisImageView imageView: UIImageView) {
        for subview in imageView.subviews {
            if subview is UIVisualEffectView {
                subview.removeFromSuperview()
            }
        }
    }
    func desaturate(UIImageView imageView: UIImageView) {
        //        let scaleFactor = UIScreen.mainScreen().scale
        //        let extent = CGRect(x: 0, y: 0, width: imageView.frame., height: <#T##CGFloat#>)
        let ciImage = CIImage(image: imageView.currentImage)
        let filterColor = CIColor(red: 255/255, green: 1/255, blue: 1/255)
        
        print("current Image = \(ciImage)")
        if let filter = CIFilter(name: "CIColorMonochrome") {

        filter.setValue(ciImage, forKey: kCIInputImageKey)
        filter.setValue(filterColor, forKey: kCIInputColorKey)
        filter.setValue(1, forKey: kCIInputIntensityKey)
            
            if let outputImage = filter.outputImage {
//        print(filter.outputImage)
//        let context = CIContext(options: nil)
//        let cgimage = context.createCGImage((filter.outputImage)!, fromRect: (filter.outputImage?.extent)!)
//        
//        let newImage = UIImage(CGImage: cgimage)
            let newImage = UIImage(CIImage: outputImage)
            imageView.image = newImage
                print("New Image: \(newImage)")
            } else {
                print("No output image from monochrome filter")
            }
//        imageView.updateCurrentImage()
        } else {
            print("broken monochrome filter")
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cellImageView.image = nil
        cellLabel.text = nil
        unblur(thisImageView: cellImageView)
    }
    
    func addPokeBall(toCell cell: PokemonCell, animated: Bool) -> UIView {
//      create a view the same size as the cell
        let indicatorView = UIView(frame: cell.bounds)
        indicatorView.opaque = false
        indicatorView.tag = 200

        
//      create an image view to hold the pokeball image
//        let containerWidth: CGFloat = 35
//        let containerHeight: CGFloat = 35
//        let imageViewContainerFrame = CGRect(
//            x: round((indicatorView.frame.size.width - containerWidth) / 2),
//            y: round((indicatorView.frame.size.height - containerHeight) / 2),
//            width: containerWidth,
//            height: containerHeight
//        )
//        let pokeBall = animatePokemball(animated, frame: imageViewContainerFrame, containerWidth: containerWidth, containerHeight: containerHeight)
//
//        indicatorView.addSubview(pokeBall)
        
        cell.addSubview(indicatorView)
        cell.userInteractionEnabled = true
        
        
        return indicatorView
    }
    func animatePokemball(animated: Bool, cell: PokemonCell, frame: CGRect, containerWidth: CGFloat, containerHeight: CGFloat) -> UIView{
        let imageViewContainer = UIView(frame: frame)
            imageViewContainer.backgroundColor = UIColor.purpleColor()
        
        
        let imageViewFrame = CGRect(
            x: round((imageViewContainer.frame.size.width - containerWidth) / 2),
            y: round((imageViewContainer.frame.size.height - containerHeight) / 2),
            width: imageViewContainer.frame.size.width,
            height: imageViewContainer.frame.size.height
        )
        
        let imageView = UIImageView(frame: imageViewFrame)
        imageView.image = UIImage(named: "PokeBall")
        imageView.backgroundColor = UIColor.yellowColor()
        
        //      add the subviews and allow use to interact through the view

        if animated {
            alpha = 0
            transform = CGAffineTransformMakeScale(1.3, 1.3) // 2
            UIView.animateWithDuration(0.3, animations: {
                self.alpha = 1
                self.transform = CGAffineTransformIdentity })
        }
        
        imageViewContainer.addSubview(imageView)
        cell.addSubview(imageViewContainer)
        print("did add subviews")
        
        return imageViewContainer
    }
    
    func removePokeBall(fromCell cell: PokemonCell, animated: Bool) {
        if let pokeBall = cell.viewWithTag(200) {
            pokeBall.removeFromSuperview()
        } else {
//            print("didn't remove PokeBall image")
        }
    }
}