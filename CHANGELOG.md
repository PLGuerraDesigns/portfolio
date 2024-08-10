## 2.5.5

- FIX: Fixed issue with router routing to the wrong page when the theme is toggled when navigating back from a different page. (Temporary fix for when the route is popped.)
- FIX: Fixed spacing issue in the home header banner.
- REVISED: Updated the home header banner subtitle to cycle through a list rather than just two.

## 2.5.4

- FIX: Fixed issue with the local video player restarting when the media browser is opened or closed.

## 2.5.3

- FIX: Fixed issue with current route not being updated when navigating to a new route. (Added a temporary fix for when the route is popped.)

## 2.5.2

- FIX: Fixed social media icons not displaying due to case sensitivity in the file path.

## 2.5.1

- NEW: Added YouTube channel to list of social media buttons.
- FIX: Fixed issue with app version number not displaying after loading while on the home page.
- REVISED: Relocated View Source Code button to the action menu.
- REVISED: Updated the media browser thumbnails for YouTube and local videos.

## 2.5.0

- NEW: Added the app version number to the action menu.
- NEW: Added a custom loading spinner.

## 2.4.3

- FIX: Fixed issue with pinch to zoom being misaligned.
- REVISED: Pinch to zoom only enabled for images.

## 2.4.2

- NEW: Added compact details page navigation buttons for mobile.

## 2.4.1

- FIX: Fixed issue with media browser scroll state not persisting when a media item is selected.

## 2.4.0

- NEW: Added the ability to expand and collapse the timeline view.
- FIX: Removed scroll under elevation for the home page app bar.
- REVISED: Wrapping timeline title widgets instead of text.
- REVISED: Project timeline entry subtitle now displays the subtitle instead of the description.

## 2.3.1

- REVISED: Revised home header banner padding.
- REVISED: Revised timeline filter chip fitment.
- REVISED: Timeline entries are now sorted by start date in descending order.
- REVISED: Revised the FrostedContainer color for light mode.

## 2.3.0

- NEW: Timeline section on home page now includes projects.
- NEW: The list of timeline entries can be filtered by type.
- NEW: Added a count of the number of timeline entries.

## 2.2.1

- FIX: Fixed issue with swiping between media items in the media player not updating the player banner details.
- FIX: Fixed issue with the media browser not registering tap events for web images.

## 2.2.0

- NEW: Added an animation to the home page subtitle to switch between the subtitle and motto.
- NEW: Added 'Report an Issue' button on the home page, redirecting to the GitHub issues page.

## 2.1.2

- ENHANCED: Added thumbnail images for videos.
- REVISED: Set HitBehavior for HoverScaleHandler to `opaque`.
- REVISED: Converted all image formats to WebP to reduce content size.
- REVISED: Implemented image_network package for YouTube thumbnail browser images.

## 2.1.1

- REVISED: Increased the Browser Thumbnail cache size.
- REVISED: Upgraded dependencies.

## 2.1.0

- ENHANCED: Added an option tooltip message to the HoverScaleHandler.
- REVISED: JSON media data has been merged into a single list of media items containing the type, path and caption. This allows for easier management of media items and enables custom ordering of media items.
- REVISED: Updated Models to use the new media data structure.
- REVISED: Converted the details page body text to a selectable text widget.
- REVISED: Embedded the MediaBrowser into the MediaPlayer to allow for browsing while keeping the player visible.
- REVISED: Removed scroll under elevation for the App Bar.
- REVISED: Updated FrostedContainer styling.

## 2.0.13

- NEW: Added Pinch to Zoom functionality to images in the media player.
- FIX: Fixed issue with media player not loading and switching between different media types correctly.
- REVISED: Added a radius to the media player and media browser thumbnails.
- REVISED: Reduced text sizes for the media player captions and the body text on the details page.
- REVISED: Replaced 'Professional' option thumbnail with a new image.
- REVISED: Updated content for Project (AMG GT3 Wheel)
- REVISED: Updated content for Professional Experience (Atlantic Insurance Company Ltd.)
- REVISED: Removed light mode profile photo. Dark mode profile photo is now used for both light and dark mode.
