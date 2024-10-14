# Zeely Technical Task

## Project Structure (MVP approach)

The project follows the Model-View-Presenter (MVP) architecture:

```
lib/
├── main.dart                 # Application entry point
├── app.dart                  # Root widget of the application
├── enums/                    # Enumerations
├── models/                   # Data models
├── views/                    # UI components
├── presenters/               # Presentation logic
├── repositories/             # Data access layer
├── styles/                   # Application styles and themes
└── utils/                    # Helper utilities
```

This structure was chosen because the application is relatively small. It provides several advantages:
- Clear separation of concerns
- Easier testing and maintenance
- Improved code organization
- Flexibility for future expansion

### Folder descriptions:

- `enums/`: Contains enumerations for metric types and periods.
- `models/`: Defines data structures and their transformations.
- `views/`: Contains UI components, responsible only for display.
- `presenters/`: Contains presentation logic, connects Model and View.
- `repositories/`: Provides abstraction for data access.
- `styles/`: Defines the application's appearance.
- `utils/`: Contains helper functions and utilities.

## Core Functionality

1. Display metrics (reach, spend, CPM) as a chart.
2. Switch between metric types.
3. Select time period for data display.
4. Interactive chart with value display on touch.

## Chart Interaction

- `MetricChart`: Main widget for chart display.
- Methods:
  - `_getSpots()`: Converts data to chart points.
  - `_parseMaxValue()`: Determines the maximum value for the Y-axis.
  - `_getLineTouchData()`: Configures chart interactivity.

## Key Components

- `HomeProvider`: Manages state and logic for the main screen.
- `MetricTypeSection`: Allows selection of the displayed metric type.
- `PeriodSelector`: Manages time period selection.
- `MetricsRepository`: Provides access to metric data.

## Running the Project

1. Clone the repository.
2. Run `flutter pub get` to install dependencies.
3. Launch the application with `flutter run`.