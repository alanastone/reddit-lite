# Reddit Lite

![image](https://images2.imgbox.com/97/61/f3gmQUSk_o.png)

Reddit client that shows top entries from Reddit (www.reddit.com/top).

## Guidelines

- Xcode 12.5 and Swift 5.
- UITableView used to display table entries.
- No third party dependencies used through the development.
- Supports all device orientation and screens.
- Storyboard used to create views.
- Based on MVVM design pattern.

## Features

- Each item in the list shows title, author, entry date, thumbnail and number of comments.
- It's also included read/unread status management using UserDefaults to store entry identifiers already seen by the user.
- By tapping the thumbnail, if a full image is provided by the API, you can visualize the image in full screen as well as share and save the image on your device.
- By tapping the item you can see de details on a second screen (or in a split view).
- Pagination is provided with pull to refresh, on the top of the table, searching for `after` items.
- Dimiss post from table with animation and storing dismissed posts using UserDefaults to keep dismissed between refreshes and launches.
- A restore button was added to the navigation bar to restore dismissed posts.

## Tests

A unit test to validate the API and result parse was included.

## What was left out?

The following items have been left out of the scope of this app due to available time:

- App state-preservation/restoration
- Dismiss All Button (remove all posts. Animations required)

## Resources

- Example video is attached

## Copyright

- Icons provided by: https://feathericons.com/
