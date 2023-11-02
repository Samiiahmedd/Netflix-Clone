//
//  SearchResultsViewController.swift
//  Netflix
//
//  Created by Sami Ahmed on 01/11/2023.
//

import UIKit
protocol SearchResultViewControllerDelegate: AnyObject {
func searchResultsViewControllerDidTapItem(_viewModel: TitlePreviewViewModel)
}

class SearchResultsViewController: UIViewController {
    public var titles : [Title] = [Title]()
    public weak var  delegate: SearchResultViewControllerDelegate?
    public let searchResultCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 10, height: 200)
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(searchResultCollectionView)
        
        searchResultCollectionView.delegate = self
        searchResultCollectionView.dataSource = self

    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchResultCollectionView.frame = view.bounds
    }
}

extension SearchResultsViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else {
            return UICollectionViewCell()
        }
        let image = UIImage(systemName: "photo")
        let title = titles [indexPath.row]
        if let photoUrl = title.poster_path {
            cell.configure(with: photoUrl)
        } else {
            cell.posterImageView.image = image
            cell.posterImageView.contentMode = .scaleAspectFit
            cell.posterImageView.tintColor = .red
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let title = titles[indexPath.row]
        let titleName = title.original_title ?? ""
        APICaller.shared.getMovie(with:titleName) {[weak self] result in
            switch result{
            case.success(let videoElement):
                self?.delegate?.searchResultsViewControllerDidTapItem(_viewModel: TitlePreviewViewModel(title: title.original_title ?? "", youtubeView: videoElement, titleOverview: title.overview ?? ""))
                
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    
    }
    
    
}
