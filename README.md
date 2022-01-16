# Leap

<img src="https://i.ibb.co/hR0S711/Simulator-Screen-Shot-i-Phone-11-Pro-2022-01-16-at-15-43-46.png" width="200" /> <img src="https://i.ibb.co/Rz7St6P/Simulator-Screen-Shot-i-Phone-11-Pro-2022-01-16-at-15-42-46.png" width="200" />

### Libraries

Two 3rd party libraries have been used for the project.

1. [UIView-Shimmer](https://github.com/omerfarukozturk/UIView-Shimmer)

This library applies the shimmering effect to the views in an easy way.

![UIView-Shimmer](https://media.giphy.com/media/YzDd2FzBNlfuOPY5WH/giphy.gif)

2. [SDWebImage](https://github.com/SDWebImage/SDWebImageSwiftUI)

It is a very popular library and this library provides an async image downloader with cache support.

### Dependency Manager

[Swift Package Manager](https://github.com/apple/swift-package-manager)

### Architecture Pattern

I chose the MVVM (Model View ViewModel) Architecture Pattern because this design pattern helps in the maintenance of the software and provides more clean and structured code.

### Function and Class Naming conventions

Camelcase: Words are delimited by capital letters, except the initial word.

### Views

I developed views (and view cells) programmatically which provides more flexibility to me. There is one storyboard on the project, this contains TabBarController and ViewControllers.

![Views](https://media.giphy.com/media/4fqFpQeTBdGf0fXjbJ/giphy.gif)

### API

I created a dummy JSON file as a backend service. You can check it on [this link](https://okb.com.tr/data.json)

### Card Tap

Card tap is triggering only an alert with the title.

<img src="https://i.ibb.co/y5V1Y8r/Simulator-Screen-Shot-i-Phone-11-Pro-2022-01-14-at-19-08-32.png" width="200" />

### Errors

I don't categorize the errors yet, I am just showing the "no internet error" view when I am getting an error. I used SwiftUI for this screen.

<img src="https://i.ibb.co/z6Xg0fz/Simulator-Screen-Shot-i-Phone-11-Pro-2022-01-14-at-21-52-48.png" width="200" />

### Other Tabs

Other tabs have not been implemented yet. Activity, Calendar, Account.

<img src="https://i.ibb.co/0MxVN1n/Simulator-Screen-Shot-i-Phone-11-Pro-2022-01-16-at-15-43-32.png" width="200" />

### Improvements

1. [bindTableViewData](https://github.com/klconur/Leap/blob/main/Leap/Controllers/HomeViewController.swift#L52) function is not flexible enough. I need to implement it in a different way.

2. Normally, I don't like to use hardcoded texts in a project but there are some hardcoded texts in this project.

3. (Sunday January 16 update) For ViewCell actions, I have added tapgesture recognizer to each view. This is not memory friendly, I would like to change it with didRowAt function.
