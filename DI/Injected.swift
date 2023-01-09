//
//  Injected.swift
//
//  Created by Denis Kovalev on 04.12.2022.
//

import Foundation

@propertyWrapper
struct Injected<T, Container: DependencyContainer> {
    var wrappedValue: T

    init(identifier: String = String(describing: T.self),
         container: Container.Type = SharedDependencyContainer.self)
    {
        wrappedValue = container.resolve(identifier: identifier)
    }
}
