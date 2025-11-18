## Assignment 7 

1. Explain what a widget tree is in Flutter and how parent-child relationships work between widgets.

A widget tree is a structure where a widget can contain other widgets (its children), and those children can contain more widgets, and so on. The parent controls the layout of its children, while the child controls how it looks inside the space given by the parent. When a parent rebuilds, it can also rebuild its children.

2. List all the widgets you used in this project and explain their functions.
   
- MyApp -> root app widget, sets up app wide things like theme and the first screen
- MaterialApp –> provides Material Design, themes, and navigation
- MyHomePage –> the home screen
- Scaffold –> page layout with appBar and body
- AppBar –> top bar showing the title
- Padding –> adds spacing around content
- Column –> arranges widgets vertically
- Row –> arranges widgets horizontally
- InfoCard -> custom widget to show one piece of info (NPM/Name/Class)
- Card (in InfoCard) –> Material card with shadow to show info
- Container –> size, padding, and layout tweaks
- Text –> displays text (NPM, name, class, title)
- SizedBox –> spacing
- Center –> centers its child
- GridView.count –> grid layout for the 3 buttons
- ItemCard –> clickable colored menu card
- Material (inside ItemCard) –> gives material surface, color, and rounded corners
- InkWell –> makes the card clickable and shows ripple
- Icon –> shows the icon in each button
- ScaffoldMessenger / SnackBar –> shows the “You have pressed …” message

3. What is the function of the MaterialApp widget? Explain why this widget is often used as the root widget.

MaterialApp sets up a Flutter app that follows Material Design, so widgets like Scaffold, AppBar, and SnackBar work with the right styling and behavior. It also provides app-wide configuration like themes, routes/navigation, and text direction. It’s often used as the root widget because everything under it can access that shared theme and navigation context.

4. Explain the difference between StatelessWidget and StatefulWidget. When would you choose one over the other?

A StatelessWidget is a widget whose UI never changes after it’s built, it only depends on the data passed into it. A StatefulWidget has a separate State object that can change over time, and when we call setState(...), Flutter rebuilds that part of the UI (for things like counters, forms, toggles, or data that loads later). Use a stateless widget when the widget just needs to display data, use a stateful widget when the widget needs to update while the app is running.

5. What is BuildContext and why is it important in Flutter? How is it used in the build method?

BuildContext is an object that represents the location of a widget in the widget tree. It is important because it allows a widget to access inherited data and other widgets above it, such as themes, media queries, navigators, or scaffold messengers. In the build method, the context is passed in so the widget can use it to build its UI correctly.

6. Explain the concept of a “hot reload” in Flutter and how it differs from a “hot restart”.

A hot reload applies code changes to the app and rebuilds the widget tree without resetting the current state. A hot restart restarts the Dart VM, runs main() again, and clears all state, so the app goes back to the initial screen. Hot reload is used for quick UI or logic updates, while hot restart is used when the change affects initialization or state setup.

## Assignment 8 

1. Explain the difference between Navigator.push() and Navigator.pushReplacement() in Flutter. In what context of your application is each best used?

Navigator.push() adds a new page on top of the navigation stack, so the previous page is still there and can be returned to with the back button. Navigator.pushReplacement() removes the current page and replaces it with a new one, so going “back” won’t return to the old page. In my application, Navigator.push() is best used for "Add Product", where the user might want to go back to the previous page after completing the form. Navigator.pushReplacement() is better for switching between main pages through the drawer menu, since it replaces the current page entirely. 

2.  How do you use hierarchy widget like Scaffold, AppBar, dan Drawer to build a consistent page structure in the your application?

Scaffold acts as the main structure that organizes the page into sections like the app bar, drawer, and body. AppBar provides a uniform header with the page title or navigation icons, keeping the top section of every page consistent. Drawer is attached to the Scaffold so users can easily access the same side navigation menu from any page, maintaining a consistent and familiar interface throughout the app.

3. In the context of user interface design, what do you think is the advantages of using layout widget like Padding, SingleChildScrollView, and ListView when displaying form elements? Provide usage examples from your application.

Padding -> adds space around each field, so it doesn't stick to the edges or to each other, making the form clearer and more comfortable to scan. In ProductForm page, each TextFormField is wrapped with Padding to seperate Name, Description, Price, etc
SingleChildScrollView -> allows the entire form to scroll, so on small screens or when the keyboard appears, all fields remain visible instead of going out of view. In ProductFormPage, Column is wrapped in a SingleChildScrollView
ListView -> useful for longer, repeatable, or dynamic lists of inputs because it scrolls by default and handles many children efficiently. Listview is used in LeftDrawer to display the drawer content in a scrollable vertical list. 

4. How do you set the color theme so that your Football Shop have a visual identity that is consistent with the shop brand.

In this app, a custom ColorScheme is defined in theme: inside MaterialApp. Widgets like AppBar, buttons, and cards then use Theme.of(context).colorScheme for their background and accent colors, so the whole app keeps a consistent look that matches the brand on every screen.

## Assignment 9 

1. Explain why we need to create a Dart model when fetching/sending JSON data. What are the consequences of directly mapping Map<String, dynamic> without using a model (in terms of type validation, null safety, and maintainability)?

A Dart model gives the JSON data a clear structure so the compiler can validate types and handle null safety. Without a model and using `Map<String, dynamic>` everywhere, everything becomes dynamic, making it easy to mistype keys or use the wrong data type without any early warnings. In the long run, models keep the codebase cleaner and easier to maintain because all JSON shape changes are handled in a single, well defined place.

2. What is the purpose of the http and CookieRequest packages in this assignment? Explain the difference between their roles.

The http is used to send basic HTTP requests like GET and POST, usually for simple, stateless APIs. CookieRequest from is designed specifically to work with Django by automatically storing and sending cookies, tracking login state, and making authenticated requests. So http just sends requests, while CookieRequest also manages the user session so the server knows which user is calling.

3. Explain why the CookieRequest instance needs to be shared across all components in the Flutter application.

CookieRequest must be shared across the entire app so every screen uses the same cookies and login session instead of creating separate ones. If each widget had its own instance, the app would lose track of whether the user is logged in, and authenticated requests would fail inconsistently. By using one shared CookieRequest through Provider, all parts of the app stay synced with the same login state and can access protected Django endpoints.

4. Explain the connectivity configuration required for Flutter to communicate with Django. Why do we need to add 10.0.2.2 to ALLOWED_HOSTS, enable CORS and SameSite/cookie settings, and add internet access permission in Android? What would happen if these configurations were not set correctly?

Flutter and Django need specific networking settings so they are allowed to communicate across the emulator and the backend. Adding 10.0.2.2 to ALLOWED_HOSTS lets the Android emulator reach the Django server, while CORS and SameSite/cookie settings ensure the app is permitted to access the API and send authentication cookies. Android also requires internet permission in the manifest so the app can make HTTP requests. If any of these are missing, the app may fail to connect, block requests due to CORS, or lose login sessions because cookies aren’t accepted. 

5. Describe the data transmission mechanism—from user input to being displayed in Flutter.

Data starts as user input in Flutter form fields, where the values are stored in variables and sent to Django as JSON using a POST request. Django receives this data, validates it, saves it to the database, and returns a JSON response. When Flutter later fetches data with a GET request, Django sends back JSON representing the saved objects. Flutter then converts that JSON into Dart model objects and uses them to build widgets so the information is displayed on the screen.

6. Explain the authentication mechanism for login, registration, and logout—from entering account data in Flutter to Django’s authentication process and displaying the menu in Flutter.

For login, Flutter sends the entered username and password to Django’s /auth/login/ endpoint using CookieRequest.login. Django checks the credentials with authenticate, creates a session on success, and returns user info along with a session cookie that CookieRequest saves for future authenticated requests. For registration, Flutter sends the new account data to Django’s register endpoint, Django validates and creates the user, and the app can then log in using the newly created account. For logout, Flutter calls Django’s logout endpoint, Django clears the session, and CookieRequest removes its stored cookies. After a successful login, Flutter navigates to the main menu and can display features that require authentication.

7. Explain how you implemented the checklist above step-by-step (not just following a tutorial).

first ensured that my Django project was running properly by creating an authentication app, adding it to INSTALLED_APPS, installing and configuring django-cors-headers, enabling CORS, adjusting cookie settings, and adding 10.0.2.2 to ALLOWED_HOSTS. I then implemented /auth/login/, /auth/logout/, and /auth/register/ views that return JSON, and exposed my product data through a /json/ endpoint so Flutter could fetch all items. After that, I set up my Flutter project by wrapping the app in a Provider to share one CookieRequest instance, created login and register pages that connect to Django, and generated a Dart model (ProductEntry) matching the Django Product model so I could parse JSON consistently. Next, I built the product list page, where I used a FutureBuilder to fetch data from the Django endpoint and displayed each item using a custom card widget. I implemented the detail page so that when I tap any product card, the app navigates to a dedicated page showing all item attributes. I also added the ability to navigate back to the list. Lastly, I added filtering: the All Products button loads every item from Django, while the My Products button sends me to a page that filters items by user_id == logged_in_user_id, ensuring I only see products I created with my current account.



