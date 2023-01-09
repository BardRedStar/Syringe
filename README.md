# Syringe

A ligh-weight DI framework based on Swift Property Wrappers

## 💿 Installation 

Add `DI` directory from this repository to your project somewhere and that's it!

## 📦 What is included

Basically, we have `SharedDependencyContainer` that holds objects as singletons for specific keys or types.
If you want to create a custom container, you can implement `DependencyContainer` protocol into your class, 
and configure your container with dependencies.

For getting dependencies from containers there is a `Injected` property wrapper. 
Also it allows getting dependencies from custom containers.

## 🪄 How to use 

First, you need to register dependencies in container. Usually, it is performed in `AppDelegate`, 
but not required to do it so.

```swift

// Definition

let someRepository = SomeRepository()

let currentUserId = "1"

// Registration

SharedDependencyContainer.register(someRepository) // Usual registration

SharedDependencyContainer.register(currentUserId, for: "user_id") // Registration for specific identifier 
```

> 💡 It's allowed to register more than one object of the same type, but you have to specify 
>  the unique identifier for each object and get them by it.

Then to get the dependency in your abstraction, simply define the variable with `@Injected` property wrapper:

```swift

class SomeViewModel {

    @Injected() 
    private var someRepository: SomeRepository

    @Injected(identifier: "user_id") 
    private var userId: String

    // Use it as usual

    func printUserId() {
        print(userId)
    }
}
```

If you need to get the dependency from the specific container, you can define it explicitly:

```swift
@Injected(container: CustomContainer.self) 
private var anotherRepository: AnotherRepository
```
