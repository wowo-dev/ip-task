# InPost Recruitment Task

## Tasks

- [x] Add grouping to the list of `Pack`s.
    - Changed the list display mechanism to `UITableView` for easier data management and better performance.
    - Added a `PackListViewModel` for separating logic from `PackListController`.
    - Grouping was implemented using the `OrderedDictionary` type from the [swift-collections](https://github.com/apple/swift-collections) library to maintain the order of dictionary elements.

- [x] Style as requested from the Design department.
    - Added a color palette as an extension to `UIColor`.
    - Separated `Assets.xcassets` into dedicated catalogues for colors and images.
    - Added fonts to the application and created a typography set.
    - Added text styles for all possibilities available in the application.
    - Added missing subviews in `PackView`, adjusted the layout to the mockup.
    - Used `NSAttributedString` in labels for precise replication of styles from the mockup (line height, kerning).
    - Added section header to `UITableView` for packs groups.
    - Adjusted colors and font of `IPNavigationController` to match the mockups.

- [x] Sort list items in groups.
    - Sorting was done using the implementation of the `Comparable` protocol in `Pack`.
    - If iOS version 15+ was supported, `SortDescriptor` could be used to avoid coupling custom sorting with `Pack` object.

- [x] Add pull to refresh and handle refresh progress.
    - Using `UITableView` for list presentation made adding pull to refresh as simple as adding `UIRefreshControl` to the table view.

- [ ] Add storing shipments locally (using Realm).
- [ ] Add local archiving of the shipment.

- [x] Fix one `Pack` appearing with unsupported status.
    - Elements with invalid data are removed from the list during decoding instead of throwing an exception for the entire list. This ensures that breaking changes in the API do not negatively impact the app's existing functionality.
    - Both `BROKEN_STATUS` and `NOT_READY` statuses are ommited.
        - `BROKEN_STATUS` - equivalent to API data error.
        - `NOT_READY` - equivalent to a new status in the API not supported by the application (Not specified in `Pack.swift`).
    - An alternative approach could be mapping unknown/new statuses to the default `UNKNOWN` status and displaying them on the list.

- [x] Fix ViewController title disappearing in Dark Mode.
    - The title is visible in Light/Dark mode by setting the navigation title color from the palette, which has defined values for both themes.

- [x] Create unit tests.
    - Added the [Sourcery](https://github.com/krzysztofzablocki/Sourcery) library for automatically generating mocks (`AutoMockable`).
    - Used the [Difference](https://github.com/krzysztofzablocki/Difference) library for clearer identification of differences between objects.
    - Added unit tests for:
        - `PackListViewModel`
        - `PackModelMapperImpl`
        - `Pack.Status`
        - `OptionalElement`

## Additional changes made

- Implementation
    - Added `Localizable.xcstrings` for managing multiple languages in the application.
    - UI changes based on the [InPost Mobile](https://apps.apple.com/pl/app/inpost-mobile/id1437787639) application.
        - Adjusted the appearance of `LaunchScreen`.
        - Added a color palette for Dark Mode.
    - Added loading, empty, error states to `PackListController` for a better user experience.
    - Optimized the shadow performance in `PackView` by setting `layer.shadowPath`.
    - Dependency injection management by using lightweight and fast framework [Factory](https://github.com/hmlongco/Factory).

- Tests
    - UI Tests for `PackListController` for the path when fetching initial data ends with error or empty list. Page Object Pattern was used for increased tests maintainability.
    - Snapshot tests for `PackListController` using [swift-snapshot-testing](https://github.com/pointfreeco/swift-snapshot-testing).

## Changes to be made in the future

- Integration of [SwiftLint](https://github.com/realm/SwiftLint) with rules based on [swift-style-guide](https://github.com/kodecocodes/swift-style-guide) to maintain a consistent codebase.
- Introduction of the Coordinator pattern to manage navigation in the project. This allows for separation of navigation from controllers and avoids the problem of excessive controller nesting.
- Removal of `Cocoapods` as they overly interfere with the project file.
- Addition of Schemes/`*.xcconfig` dedicated to the API environment for easier management of application distributions.
- Addition of analytics mechanism to collect information on how users use the application for future UX improvements.
- Implementation of error tracking and reporting to the error collection system for quick response and issue resolution before user reports.
- Creation of templates (`*.xctemplate`) for objects in the application (MVVM, Coordinators) for faster creation of new components.
- Extraction of the UI layer into a separate framework (DesignSystem). This allows to maintain consistency in appearance across multiple applications using the same UI source.
- Hot reloading using [Inject](https://github.com/krzysztofzablocki/Inject) for faster UI refinement.
- Restructuring the project structure by extracting modules (e.g., network layer, shared models, parsers) into separate frameworks. This facilitates maintenance of individual areas of the application and allows their use in other applications.

