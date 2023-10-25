//
//  CollectionViewTableViewCell.swift
//  Netflix
//
//  Created by Sami Ahmed on 25/10/2023.
//

import UIKit

class CollectionViewTableViewCell: UITableViewCell{
    
    private var Titles : [Title] = [Title]()
    
    static let identifier = "CollectionViewTableViewCell"
    
    private let collectionView: UICollectionView = {
        
    let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 140, height: 200)
    layout.scrollDirection = .horizontal
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        return collectionView
  }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .green
        contentView.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
       collectionView.frame = contentView.bounds
    }
    public func configure(with titles:[Title]){
        self.Titles = titles
        DispatchQueue.main.async{[weak self] in
            self?.collectionView.reloadData()
        }
        
    }
}
extension CollectionViewTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else  {
            return UICollectionViewCell()
     
        }
        guard let model = Titles[indexPath.row].poster_path else {
            return UICollectionViewCell()
            
        }
        cell.configure(with:model)
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Titles.count
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let title = Titles[indexPath.row]
        guard let titleName = title.original_title ?? title.original_name else {
            return
        }
        
        APICaller.shared.getMovie(with: titleName + "trailer") { result in
            switch result {
            case.success(let videoElement):
                print(videoElement.id)
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
   
    
}
