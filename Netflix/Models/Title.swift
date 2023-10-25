//
//  Movie.swift
//  Netflix
//  Created by Sami Ahmed on 30/10/2023.

import Foundation
struct TrendingTitleResponse: Codable {
    let results : [Title]
}

struct Title : Codable {
    let id: Int
    let poster_path : String?
    let title: String?
    let original_language: String?
    let original_title: String?
    let overview: String?
    let media_type: String?
    let popularity: Double?
    let release_date: String?
    let vote_average: Double?
    let vote_count: Int?
    let original_name : String?
}

