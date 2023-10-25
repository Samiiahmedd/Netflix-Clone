//
//  HeroHeaderView.swift
//  Netflix
//
//  Created by Sami Ahmed on 28/10/2023.
//

import UIKit

class HeroHeaderView: UIView {
    
    private let downloadButon : UIButton = {
        let button = UIButton()
          button.setTitle("Download", for: .normal)
          button.layer.borderColor = UIColor.white.cgColor
          button.layer.borderWidth = 1
          button.translatesAutoresizingMaskIntoConstraints = false
          button.layer.cornerRadius = 5
          return button
        
        
        
        
    }()
    
    private let playButton : UIButton = {
      let button = UIButton()
        button.setTitle("Play", for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        return button
        
        
    }()
    
    private let heroImageView : UIImageView = {
    let ImageView = UIImageView()
        ImageView.contentMode = .scaleAspectFill
        ImageView.clipsToBounds = true
        ImageView.image = UIImage(named:"Poster5")
        return ImageView
    
    }()
    
    private func addGradient(){
    let GradientLayer = CAGradientLayer()
        GradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.black.cgColor
        ]
        
        GradientLayer.frame = bounds
        layer.addSublayer(GradientLayer)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(heroImageView)
        addGradient()
        addSubview(playButton)
        addSubview(downloadButon)
        applyConstrains()
        
    }
    
    private func applyConstrains(){
        
        let playButtonConstrains = [
            playButton.leadingAnchor.constraint(equalTo: leadingAnchor,  constant:50 ),
            playButton.bottomAnchor.constraint(equalTo: bottomAnchor,  constant:-50 ),
            playButton.widthAnchor.constraint(equalToConstant: 120)
        ]
        
        let downloadButtonConstrains = [
            downloadButon.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            downloadButon.bottomAnchor.constraint(equalTo:bottomAnchor, constant: -50),
            downloadButon.widthAnchor.constraint(equalToConstant: 120)
        ]

        
        NSLayoutConstraint.activate(playButtonConstrains)
        NSLayoutConstraint.activate(downloadButtonConstrains)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        heroImageView.frame = bounds
    }
    
    required init?(coder : NSCoder) {
        fatalError()
    }



}
