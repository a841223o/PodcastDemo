//
//  APIError.swift
//  PodcastDemo
//
//  Created by leo on 2022/6/14.
//

import Foundation


public enum APIError : Error {
    case unexpect
    case apiError(Error)
}
