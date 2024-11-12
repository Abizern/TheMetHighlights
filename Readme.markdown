
#  The Met

A simple app to show items with images from the Metropolitan Museum of Art that have been deemed as popular and important items in their collection.

Some of the Departments have no items thet fit these criteria, so they may show as empty.

Uses the API available at https://metmuseum.github.io/

Licenced using the Creative Commons CC-0 licence which matches that of the data source.

## Usage

### Departments 
Shows the list of Departments. Some of these departments may not have any highlighted items, so there will be nothing to display in their detail view.
Tapping on a department will take you to the Department screens

### Department
Shows the exhibits that are available have highlighted items with images. Tapping on one of these items will take you to the Exhibit Screen

### Exhibit
Shows some information about the piece along with a larger picture.

Tapping on the picture will take you to a screen that shows a larger view.

## Requirements

- Xcode 16+
- iOS 18+

## Architecture

SwiftUI with View models in a single Xcode Project

I'm using a couple of dependencies from Pointfree.co, notably SwiftDependencies to make tests and previews more controllable. Since there isn't much interaction [TCA](https://github.com/pointfreeco/swift-composable-architecture) might have been overkill, but it might have given better test coverage.

## Tests
I've used Swift Testing, and organised the tests into Suites, but there are no tags.


## Improvements

- Better UI Design, it's rather plain.
- Snapshot tests to validate views and layouts.
- Move navigation destinations outside of the View. Not an issue with a single flow app like this, but for more complex flows this reduces coupling and is more maintainable.
- Modularisation: Turn features and helper code into SPM libraries.
- Better image cacheing - responses use the URLCache configured on URLSession, but the thumbnail images are resized and it might be better to use an image cache for those.
- Better display of the larger image.
- More functionality:
  - Favourites.
  - Share Sheet.