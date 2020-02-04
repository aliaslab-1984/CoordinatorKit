# CoordinatorKitPackage

This frameworks contains useful protocols for the implementation of the famous **Coordinator** Architectural pattern in iOS.

In the package you can find three key protocols: 

- Coordiator protocol: Make a class conform to this protocol to get a basic coordinator object.
- Router protocol: this protocol is the delegate for navigation inside the app. It is initialized with a navigation controller.
- Storyboard instantiable: A protocol that handles the creation of a view controller both from storyboard and programmatically. It also handles the injection of dependencies in the created instances.
