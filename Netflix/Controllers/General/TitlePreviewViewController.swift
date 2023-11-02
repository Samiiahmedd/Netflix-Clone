//
//  TitlePreviewViewController.swift
//  Netflix
//
//  Created by Sami Ahmed on 02/11/2023.
//

import UIKit
import WebKit

class TitlePreviewViewController: UIViewController {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22,weight: .bold)
        label.text = "Harry potter"

        return label
    }()
    
    private let overviewLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.text = "this is the best movie"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private let downloadButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red
        button.setTitle("Download", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        return button
    }()
    
    private let webview :WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(webview)
        view.addSubview(titleLabel)
        view.addSubview(overviewLabel)
        view.addSubview(downloadButton)
        
        configureConstrains()
    }
    
    func configureConstrains(){
    let webViewConstrains = [
        webview.topAnchor.constraint(equalTo: view.topAnchor,constant: 50),
        webview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        webview.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        webview.heightAnchor.constraint(equalToConstant: 250)
        
    ]
        
        let titleLabelConstrains = [
            titleLabel.topAnchor.constraint(equalTo: webview.bottomAnchor,constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20)
        ]
        let downloadButtonConstrains = [
            downloadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            downloadButton.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor,constant: 20),
            downloadButton.widthAnchor.constraint(equalToConstant: 120),
            downloadButton.heightAnchor.constraint(equalToConstant: 50)
        ]
        
        let overViewLabelConstrains = [
            overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 15),
            overviewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            overviewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        NSLayoutConstraint.activate(downloadButtonConstrains)
        NSLayoutConstraint.activate(overViewLabelConstrains)
        NSLayoutConstraint.activate(webViewConstrains)
        NSLayoutConstraint.activate(titleLabelConstrains)
    }
    func configure(with model : TitlePreviewViewModel){
        titleLabel.text = model.title
        overviewLabel.text = model.titleOverview
        
        
        guard let url = URL(string: "https://www.youtube.com/embed/\(model.youtubeView.id.videoId)") else {
            return
        }
        webview.load(URLRequest(url: url))

    }



}
