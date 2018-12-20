//
//  ViewController.swift
//  December-19th
//
//  Created by Joey Essak on 12/19/18.
//  Copyright © 2018 Joey Essak. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    //instance propertys
    var anotherSound = AVAudioPlayer()
    let imageView = UIImageView(image: #imageLiteral(resourceName: "Image-Photo_01"))
    let visualEffectView = UIVisualEffectView(effect: nil)   //Here is the UIViewPropertyAnimator code
    let animator = UIViewPropertyAnimator(duration: 0.5, curve: .linear, animations: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        func loadMusic()
        {
            if let path = Bundle.main.path(forAuxiliaryExecutable: "Gotti.mp3")
            {
                let url = URL(fileURLWithPath: path)
                do{
                    anotherSound = try AVAudioPlayer(contentsOf: url)
                    
                    anotherSound.numberOfLoops = -1
                    anotherSound.play()
                }
                catch {
                    print("cant find audio file")
                }
            }
            
            
        }
        loadMusic()
        
        
        
        
        
        setupCenteredImageView()
        
        // visual blurr effect view
        setupVisualBlurrEffectView()
        
        setupSlider()
        
        animator.addAnimations {
            // completed animated state
            self.imageView.transform = CGAffineTransform(scaleX: 4, y: 4)
            self.visualEffectView.effect = UIBlurEffect(style: .regular)
        }
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    fileprivate func setupVisualBlurrEffectView(){
        
        
        // let blurEffect = UIBlurEffect(style: .regular)
        
        view.addSubview(visualEffectView)
        visualEffectView.fillSuperview()
        
    }
    
    
    
    fileprivate func setupSlider()
    {
        let slider = UISlider()
        view.addSubview(slider)
        slider.anchor(top: imageView.bottomAnchor, leading: imageView.leadingAnchor, bottom: nil, trailing: imageView.trailingAnchor)
        slider.addTarget(self, action: #selector(handleSliderChange), for: .valueChanged)
        
    }
    
    @objc func handleSliderChange(slider: UISlider)
    {
        print(slider.value)
        animator.fractionComplete = CGFloat(slider.value)
    }
    
    
    
    @objc  func handleTap()
    {
        UIView.animate(withDuration: 1.0)
        {
            self.imageView.transform = CGAffineTransform(scaleX: 2, y: 2)
        }
    }
    
    
    fileprivate func setupCenteredImageView()
    {
        view.addSubview(imageView)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.centerInSuperview(size: .init(width: 200, height: 200))
    }
    
    
    
}

