//
//  Injection.swift
//  Nihongo
//
//  Created by Franck Petriz on 12/09/2023.
//

import Foundation

// Go check https://www.avanderlee.com/swift/dependency-injection/ for an amazing tutorial
// about dependencies injections with Swift UI

public protocol InjectionKey {

    /// The associated type representing the type of the dependency injection key's value.
    associatedtype Value

    /// The default value for the dependency injection key.
    static var currentValue: Self.Value { get set }
}

@propertyWrapper
struct Injected<T> {
    private let keyPath: WritableKeyPath<InjectedValues, T>
    var wrappedValue: T {
        get { InjectedValues[keyPath] }
        set { InjectedValues[keyPath] = newValue }
    }

    init(_ keyPath: WritableKeyPath<InjectedValues, T>) {
        self.keyPath = keyPath
    }
}
