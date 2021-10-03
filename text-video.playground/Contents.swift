//: A UIKit based Playground for presenting user interface
  
import UIKit
import Foundation
import PlaygroundSupport

import AVKit
import CoreImage.CIFilterBuiltins


        let view = UIView(frame: CGRect(x: 0, y: 0, width: 640, height: 834))
view.backgroundColor = UIColor.black



      let waterfallURL = Bundle.main.url(forResource: "waterfall", withExtension: "mov")
let waterFallItem = AVPlayerItem(url: waterfallURL!)

let titleComposition = AVMutableVideoComposition(asset: waterFallItem.asset) { request in
//  let textFilter = CIFilter.textImageGenerator()
//  textFilter.text = "Waterfall!"
//  textFilter.fontSize = 72
//  textFilter.fontName = "Marker Felt"
//  textFilter.scaleFactor = 2.0

  let textFilter = CIFilter.attributedTextImageGenerator()
    let waterfallText = NSAttributedString(string: "Waterfall!", attributes: [NSAttributedString.Key.foregroundColor : UIColor.blue, NSAttributedString.Key.font : UIFont(name: "Marker Felt", size: 72.0)!])
  textFilter.text = waterfallText
  textFilter.scaleFactor = 2.0

  let whiteText = textFilter.outputImage!.transformed(by: CGAffineTransform(translationX: (request.sourceImage.extent.width - textFilter.outputImage!.extent.width)/2, y: 200))

  request.finish(with: whiteText.composited(over: request.sourceImage), context: nil)
}

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
