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

