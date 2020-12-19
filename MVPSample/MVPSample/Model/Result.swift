//
//  Result.swift
//  MVPSample
//
//  Created by kazuya on 2020/12/19.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(ResultError)
}

enum ResultError: Error {
    case FetchError(String, Int)
}
