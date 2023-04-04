# Problem 5
Implement a Landing page that will list all userstories.

## Scope:

### Functional:

- Ability to retrieve actual events data via mock data.
- Ability to go back and forth between the list and detail screen.
- Apply pagination mechanism.
- Good UI animations and consistent UI elements.

### Non-Functional:
- Scalability:
  - Modularity for every main feature.
  - Flexible UI with Delegation pattern.
- Reliability:
  - Unit tests for UI and non-UI part.
  
## Design Decisions:

### UI:
  - 100% Swift UI
  - MVVM-C Architecture
### Principals and Patterns:
  - SOLID conformance:
    - Features are separated into modules.
     - UseCases for business logic.
  - Utilizing IoC and DI.
  - Delegation pattern for View provider.
  - Coordinator pattern for navigation.
### Dependency Manager:
  - Swift Package Manager
### Dependencies:
  - [ViewInspector](https://github.com/nalexn/ViewInspector "ViewInspector"): is a library for unit testing SwiftUI views. It allows for traversing a view hierarchy at runtime providing direct access to the underlying View structs. SwiftUI view is a function of state. We could provide it with the input, but were unable to verify the output, so this library will give us a hand.
  - [Swinject](https://github.com/Swinject/Swinject "Swinject"): Dependency injection framework.
  - [Kingfisher](https://github.com/onevcat/Kingfisher "Kingfisher"): Downloading and caching images from the web.
  - [AttributedText](https://github.com/Iaenhaall/AttributedText "AttributedText"): HTML text processing, it makes text decoration easier in iOS 14. In iOS 15+ we can use markup for Text in SwiftUI, so we can remove this dependency.
  - [StatefulTabView](https://github.com/NicholasBellucci/StatefulTabView "StatefulTabView"): Help me customize the bottom tab bar with the built in badge feature, not too important as it's not the main feature.


## Architecture Design
![](https://raw.githubusercontent.com/mrkazansky/swiftui-mvvm-c/master/documents/architect_diagram.png)

### Data Layer
Data Access Layer consists of Services. 
Service provides asynchronous APIs for networking or local data, and pass data as a Publisher from Combine framework. It is accessible and used only by the Usecase in the business layer. We can understand service as Repository pattern.

In this project, `EventListNetworkService` stand for Services, which receives requests to get the event list from the given remote endpoint (with faked data).

`EventListNetworkService` comforms to `EventListService` such that we can use dependency injection to inject `MockEventListService` in Usecase in unit tests.

### Business Layer
Business Logic Layer includes Usecases.

In this project, `EventListNetworkUsecase` stand for Usecase,which receives requests to download and process the events list from the `EventListNetworkService`.

### Presentation Layer
Presentation Layer is represented by View and ViewModel.

ViewModels work between Views and Usecases, encapsulating business logic to the Views. ViewModels are downstream subscribers that receive and process whatever is passed from upstream publishers. They are marked as @ObservedObject such that SwiftUI is able to monitor ViewModels for updates and redraw the UI.

Views are independent from business logic. Side effects are triggered by the view lifecycle event onAppear and are forwarded to the corresponding the ViewModel.

## Project Structure:

Thanks to Swift Package Manager, I can make project modular easier than ever. This project has an overview structure as follows:

- Main
  - Packages:
    - Utilities: 
      - Sources: Includes extension and utility features, can be used by most modules.
      - Tests: Unit test for extension function. If needed.
    - Networking: 
      - Sources: Includes Network client & related protocol for Request/Response, can be used by Services class.
      - Tests: Unit test for network classes. If needed.
    - Model:
      - Source: Includes models for projects. Technically, if we follow Clean Architect concept, we should have seperate model for each layer.
      - Tests: Unit test suites for models class.
  - App:
    - Manifest: Includes App Delegate & Window scene, which handle application's root view.
    - Core:
      - Coordinator: Includes Coordinator for every features group.
      - DI: Includes scope and dependencies defination.
    - Features:
      - Home :
        - Source:
          - Resource: Includes Asset, Localization or any resources file.
          - ViewModel: Includes ViewModel for this feature.
          - View: Includes Viewes for this feature.
        - Tests: Unit test suites for home related classes. If needed.
      - Event Detail:
        - Source:
          - Resource: Includes Asset, Localization or any resources file.
          - ViewModel: Includes ViewModel for this feature.
          - View: Includes Viewes for this feature.
        - Tests: Unit test suites for event detail related classes.
      - Event List:
        - Source:
          - Resource: Includes Asset, Localization, Raw JSON or any resources file.
          - Data: Includes Services for this feature.
          - Usecase: Includes Usecases for this feature.
          - ViewModel: Includes ViewModel for this feature.
          - View: Includes Viewes & Event Row View Provider for this feature.
        - Tests: Unit test suites for event list related classes.


## Build instructions:

- Xcode 14.2
- Thanks again to Swift Package Manager, we do not need any special build initialization process.

## What could be improved:

With the mindset that we need to test everything we have written, it is never superfluous to write more unit tests.
