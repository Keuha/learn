//
//  Loadable.swift
//  Nihongo
//
//  Created by Franck Petriz on 25/08/2023.
//

import Foundation

import Foundation
import Combine

enum CustomError: Error {
    case userCancelled
}

enum Loadable<Value> {
    
    case notRequested
    case loading(Value?, CancelBag)
    case loaded(Value)
    case error(Error)
    
    var value: Value? {
        switch self {
            case let .loaded(value):
                return value
            case let .loading(last, _):
                return last
            default: return nil
        }
    }
    
    var notRequested : Bool {
        switch self {
        case .notRequested:
                return true
        default:
            return false
        }
    }

    @MainActor mutating func setIsLoading(_ cancelToken: CancelBag = CancelBag()) {
        self = .loading(value, cancelToken)
    }

    @MainActor mutating func setError(_ error: Error) {
        self = .error(error)
    }

    @MainActor mutating func setValue(_ value: Value) {
        self = .loaded(value)
    }

    mutating func cancelLoading() {
        switch self {
        case let .loading(last, cancelBag):
            cancelBag.cancel()
            if let last = last {
                self = .loaded(last)
            } else {
                self = .error(CustomError.userCancelled)
            }
        default:
            break
        }
    }
}
