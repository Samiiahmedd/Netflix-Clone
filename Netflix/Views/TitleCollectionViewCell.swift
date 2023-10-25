//
//  TitleCollectionViewCell.swift
//  Netflix
//
//  Created by Sami Ahmed on 31/10/2023.
//

import UIKit
import SDWebImage
class TitleCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "TitleCollectionViewCell"
    
    let posterImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
         
    }()
    
    #warning("----")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(posterImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        posterImageView.frame = contentView.bounds
    }
    
    public func configure(with model : String){
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model)") else {
            return
            
        }
                posterImageView.sd_setImage(with: url, completed : nil)
            }
        }

