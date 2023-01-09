//
//  Container.swift
//
//  Created by Denis Kovalev on 27.11.2022.
//

import Foundation

protocol DependencyContainer {
    static func register<T>(_ dependency: T)
    static func register<T>(_ dependency: T, for identifier: String)
    static func resolve<T>(identifier: String) -> T
}

final class SharedDependencyContainer: DependencyContainer {
    // MARK: - Static

    private static var shared = SharedDependencyContainer()

    static func register<T>(_ dependency: T) {
        shared.register(dependency, for: String(describing: T.self))
    }

    static func register<T>(_ dependency: T, for identifier: String) {
        shared.register(dependency, for: identifier)
    }

    static func resolve<T>(identifier: String) -> T {
        shared.resolve(with: identifier)
    }

    // MARK: - Private

    private var dependencies = [String: AnyObject]()

    private func register<T>(_ dependency: T, for identifier: String) {
        let id = dependencyIdentifier(withCustomIdentifier: identifier, type: T.self)
        dependencies[id] = dependency as AnyObject
    }

    private func resolve<T>(with identifier: String) -> T {
        let id = dependencyIdentifier(withCustomIdentifier: identifier, type: T.self)
        let dependency = dependencies[id] as? T

        precondition(
            dependency != nil,
            """
                No dependency found for \(String(describing: T.self))!
                Dependency must be registered with \(String(describing: self)).register(:for:) before resolve.")
            """
        )
        return dependency!
    }

    private func dependencyIdentifier<T>(withCustomIdentifier identifier: String, type: T.Type) -> String {
        return "\(identifier)_\(String(describing: T.self))"
    }
}
