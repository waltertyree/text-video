//: A UIKit based Playground for presenting user interface

import UIKit
import PlaygroundSupport

import AVFoundation
import CoreImage.CIFilterBuiltins

//Create a view to display our work
let view = UIView(frame: CGRect(x: 0, y: 0, width: 500, height: 900))
view.backgroundColor = UIColor.black


//Fetch a URL for the movie from the bundle
let waterfallURL = Bundle.main.url(forResource: "waterfall", withExtension: "mov")

//Create an AVAsset with the url
let waterfallAsset = AVAsset(url: waterfallURL!)

//Create a composition with the AVAsset
let titleComposition = AVMutableVideoComposition(asset: waterfallAsset) { request in

//Create a white shadow for the text
  let whiteShadow = NSShadow()
  whiteShadow.shadowBlurRadius = 5
  whiteShadow.shadowColor = UIColor.white

  let attributes = [
    NSAttributedString.Key.foregroundColor : UIColor.blue,
    NSAttributedString.Key.font : UIFont(name: "Marker Felt", size: 36.0)!,
    NSAttributedString.Key.shadow : whiteShadow
  ]

  //Create an Attributed String
  let waterfallText = NSAttributedString(string: "Waterfall!", attributes: attributes)

  //Convert attributed string to a CIImage
  let textFilter = CIFilter.attributedTextImageGenerator()
  textFilter.text = waterfallText
  textFilter.scaleFactor = 4.0

  //Center text and move 200 px from the origin
  //source image is 720 x 1280
  let positionedText = textFilter.outputImage!.transformed(by: CGAffineTransform(translationX: (request.renderSize.width - textFilter.outputImage!.extent.width)/2, y: 200))

  //Compose text over video image
  request.finish(with: positionedText.composited(over: request.sourceImage), context: nil)
}

let waterFallItem = AVPlayerItem(asset: waterfallAsset)

waterFallItem.videoComposition = titleComposition

let player = AVPlayer(playerItem: waterFallItem)

let playerLayer = AVPlayerLayer(player: player)
playerLayer.frame = view.layer.bounds
playerLayer.videoGravity = .resizeAspect

view.layer.addSublayer(playerLayer)

player.play()


// Present the view controller in the Live View window
PlaygroundPage.current.liveView = view
PlaygroundPage.current.needsIndefiniteExecution = true
