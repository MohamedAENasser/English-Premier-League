# Welcome to English premier league application.

By using this SwiftUI application, you will be able to follow up the upcoming English premier league matches and check the results of the previous matches.

Steps followed while implementing the application:

- Created the API key and checked the EndPoint response and created the Model based on needed data.
- The architecture used is MVVM, used it since ViewModel is pure logic and it’s not coupled with the view code, this will helps on clean visibility of the logic behavior and helps a lot with adding tests to the app.
- Created a Service class to handle APIs calls which will be injected to the ViewModel.
- For Networking used Moya framework, which is using Alamofire logic under the hood but adding a higher level of enums to facilitate dealing with multiple endpoints.
- Used Async Await methodology in the ViewModel to fetch the matches data from the service object then working on that data to properly display it.
- Used Combine in `FixturesViewModel` to observe `state` changes and update the presented matches accordingly, also used in `FixtureCellViewModel` to observe favorite changes and update the favorites list accordingly.

- Created multiple screens for the application flow.
	- `SplashView` screen: the first screen that the user will see contains an image with English premier league logo and progress view that counts 3 seconds before starting the app. we should be calling the initial APIs (e.x Login) in this screen instead of hardcoded 3 seconds but as we don't have these data for now so there are no real APIs are called.
	- `MainMenuView`: Contains the main UI the user will need to select between, currently the available option is "See matches list button".
	- `LoadingView`: A view with progress view to be used when there is APIs calling is in progress, will be shown when matches list screen starts to load data.
	- `FixturesView`: A view with list presenting the matches list using List component, and a toggle view to allow user to select what to present in this list either to show favorite matches only or all matches.
	- `FixtureCell`: A view to display the content of each match on the list.
	- `ErrorView`: A view that will appear if there is an error occurred while fetching the data, giving the user an option to retry fetching the data by tapping on retry button.
	- `EmptyStateView`: will be displayed in one of the following scenarios, 
		- if the fetched matches list is empty notifying the user that there are no available matches in the meantime.
		- if the user selected to show only favorite matches when there are no matches marked as favorite, notifying the user to mark matches as favorites to be able to filter them

- Added long press action to match cell to show options list with mark as a favorite as a second way to mark the match as favorite beside tapping on the star icon on the cell.
- Added pull to refresh functionality allowing the user to scroll the list to load more matches from previous days.
  - Extra logic added to loading behavior to facilitate user navigation, the days loaded are getting increased every time up to loading 7 days per time to allow users to get back to previous matches easily if the match was played long time ago.
- Handled dark mode colors by creating Color assets catalog and added custom color sets.
- Added unit testing to test the full logic used in view models, 
	- Used Moya's sample data to simulate mock data needed for the unit tests and added full tests to make sure that the data is properly handled from fetching to presentation.

*Note:*

To run the application properly and get data, the API_KEY value in `EnglishLeagueTarget` file should be updated to a valid one.

`there are many ways to keep it secure either locally or remotely but safe ways will need back end handling thats why its skipped for now.`

*Application walkthrough (light/dark) modes:*

https://user-images.githubusercontent.com/30662141/228078337-86cabd1a-ac56-4bdb-84c7-92b5b299d1a4.mp4

https://user-images.githubusercontent.com/30662141/228078312-2de1e54c-104c-4216-aee5-0736b1e2a767.mp4
