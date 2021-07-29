//
//  ListLoader.swift
//  pokxchange
//
//  Created by abdelillah ghomari on 7/6/21.
//
enum ImageLoaderState {
    case loading, success, failure
}

enum LoaderState<T> {
    case idle
    case loading
    case failed(Error)
    case loaded([T])
}
