
# Animal explorer

AnimalExplorer is an iOS application developed using SwiftUI and The Composable Architecture (TCA).

## Installation

1. **Clone the repository:**

   ```bash
   git clone https://github.com/AndriiBoichuk/AnimalExplorer.git
   cd AnimalExplorer
   ```

2. **Open the project in Xcode:**

   ```bash
   open AnimalExplorer.xcodeproj
   ```

3. **Install dependencies:**

   Ensure you have Swift Package Manager configured in your Xcode project to handle TCA dependencies.

4. **Build and run the project:**

   Select the appropriate target device and hit the run button in Xcode.

## Usage

The app provides a list of animals, each with detailed information and images. Users can navigate through the list and select an animal to view more details.

## Architecture

The app follows The Composable Architecture (TCA) principles, providing a predictable state management solution and making the codebase modular and testable.

### Core Data Management

AnimalExplorer uses a custom library (is written by me) for Core Data management ([link to the library](https://github.com/AndriiBoichuk/CoreDataLayer)). This library handles all Core Data related tasks, ensuring efficient and reliable data storage and retrieval.

