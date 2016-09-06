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
            caughtPokemon(self)
        } else {
            releasePokemon(self)
        }

    }
    
    func caughtPokemon(cell: PokemonCell) {
        addPokeBall(toCell: cell, animated: true)
        cellImageView.stopAnimatingGif()
        pokemon?.isCaught = true
        desaturate(UIImageView: cell.cellImageView)
//        blur(thisImageView: cellImageView)
//        print("caught!")
    }
    func releasePokemon(cell: PokemonCell) {
        removePokeBall(fromCell: cell, animated: true)
        pokemon?.isCaught = false
        cellImageView.startAnimatingGif()
        unblur(thisImageView: cellImageView)
//        print("uncaught!")
    }
    
    func blur(thisImageView imageView: UIImageView) {
        let blurEffect = UIBlurEffect(style: .ExtraLight)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.frame = imageView.bounds
        blurredEffectView.alpha = 0.5
//        blurredEffectView.frame.insetInPlace(dx: 25.0, dy: 5.0)
//        let vibrancyEffect = UIVibrancyEffect(forBlurEffect: blurEffect)
//        let vibrancyEffectView = UIVisualEffectView(effect: vibrancyEffect)
//        vibrancyEffectView.frame = imageView.bounds
//        
//        imageView.addSubview(vibrancyEffectView)
//        addCheck(toImageView: blurredEffectView)

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
        let containerWidth: CGFloat = 35
        let containerHeight: CGFloat = 35
        let imageViewFrame = CGRect(
            x: round((indicatorView.frame.size.width - containerWidth) / 2),
            y: round((indicatorView.frame.size.height - containerHeight) / 2),
            width: containerWidth,
            height: containerHeight
        )
        let imageView = UIImageView(frame: imageViewFrame)
            imageView.image = UIImage(named: "PokeBall")
        
//      add the subviews and allow use to interact through the view
        indicatorView.addSubview(imageView)
        
        cell.addSubview(indicatorView)
        cell.userInteractionEnabled = true
        
        return indicatorView
    }
    func removePokeBall(fromCell cell: PokemonCell, animated: Bool) {
        if let pokeBall = cell.viewWithTag(200) {
            pokeBall.removeFromSuperview()
        } else {
//            print("didn't remove PokeBall image")
        }
    }
}