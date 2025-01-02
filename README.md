**Setup Instructions for Dependencies and Hive Initialization**

Add the following dependencies to your pubspec.yaml file|

dependencies:
flutter:
sdk: flutter
get: ^4.6.5
http: ^0.15.0
location: ^4.4.0
hive: ^2.2.3
hive_flutter: ^1.1.0
path_provider: ^2.0.12
permission_handler: ^10.2.0
image_picker: ^0.8.7+3


2. Hive Initialization

   Hive is used to store uploaded images locally. Follow these steps to initialize Hive:

Import hive and hive_flutter in your main.dart file.
Call Hive.initFlutter() before running the app.


Architecture and Components
Architecture:
The application follows the MVC (Model-View-Controller) pattern using GetX for state management. Here's how the components are structured:

Models:

Represent the data structure for user information fetched from the API.
Example: UserModel defines fields like id, email, firstName, lastName, and avatar.
Views:

The UI layer where the widgets and screens are defined.
It observes the state managed by the controller and updates dynamically.
Key files:
home_view.dart: Displays the current location and list of users.
user_list_view.dart: Contains the ListView to display user details.
Controllers:

Act as a bridge between models and views, handling business logic and API interactions.
Example: UserController handles:
Fetching data from the API.
Managing location data.
Uploading and storing user images.
Retrieving images from local storage.
Services:

Handles API calls and external operations like HTTP requests.
Example: ApiService is responsible for fetching user details from the provided API endpoint.
Key Components
State Management with GetX:

Used for reactive programming to manage UI state dynamically.
Obx widget listens to changes in observable variables and rebuilds the UI automatically.
Location Handling:

Retrieves the current location using the location package.
Displays latitude, longitude, and address.
Image Upload and Local Storage:

Handles image selection from the gallery using the image_picker package.
Stores images locally