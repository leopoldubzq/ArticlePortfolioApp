# Article Portfolio App

<img src="https://github.com/leopoldubzq/ArticlePortfolioApp/assets/60520591/7dbdcfcd-04d9-45c4-b2ab-5901aec4c41a" width="300"/>

## Description
**Article Portfolio App** is a mobile iOS application designed to display technology-related articles. By default, the app shows top headlines, but users can search for specific tech articles using queries. Users can also add specific articles to their favorites and view them in a dedicated "Favorites" tab. The app is built using SwiftUI with a clean MVVM architecture, utilizing Combine and the Moya framework. The project also includes unit tests with mock servers. Additionally, the app includes a watchOS companion app which communicates with its parent (iOS) app. In the watchOS app, users can browse through top headlines articles and add or remove articles from favorites. All changes are successfully updated on both sides – iOS and watchOS.

## Features
- Display top tech headlines
- Search for tech articles by specific queries
- Add articles to favorites
- View favorite articles in a dedicated tab
- Built with SwiftUI
- Uses SwiftData (in order to save favourite articles locally)
- MVVM pattern
- clean architecture with separated layers such as Netowork or Domain
- Utilizes Combine and Moya framework
- Includes **watchOS** companion app:
  - Browse top headlines
  - Add or remove articles from favorites
  - Synchronize changes between iOS and watchOS
- Unit tests with mock servers
- Supports light and dark mode

## iOS
<div style="display: flex; flex-direction: row;">
   <img src="https://github.com/leopoldubzq/ArticlePortfolioApp/assets/60520591/b5b457b3-3321-480d-a663-6d6ad0034b0f" width="250"/>
   <img src="https://github.com/leopoldubzq/ArticlePortfolioApp/assets/60520591/d36c5f5d-f996-4a77-960c-8a88a4ad8fe3" width="250"/>
   <img src="https://github.com/leopoldubzq/ArticlePortfolioApp/assets/60520591/f614572e-f574-448f-9df9-78782bd6b3bc" width="250"/>
</div>

## watchOS
<div style="display: flex; flex-direction: row;">
  <img src="https://github.com/leopoldubzq/ArticlePortfolioApp/assets/60520591/8728fded-aa53-411f-9048-b835832d367d" width="250"/>
  <img src="https://github.com/leopoldubzq/ArticlePortfolioApp/assets/60520591/f22c8bec-476e-4e3e-966d-3649d1ce136a)" width="250"/>
  <img src="https://github.com/leopoldubzq/ArticlePortfolioApp/assets/60520591/a90fb438-599e-4d35-9b6b-aef01681a8c5" width="250"/>
</div>

## Usage
Upon launching the app, you will see the top tech headlines by default. To search for specific articles:

1. **Tap on the search bar.**
2. **Enter your query.**
3. **Browse through the search results.**
   
To add an article to your favorites:

1. **Tap on the article you want to add.**
2. **Click the 'Add to Favorites' button.**

To view your favorite articles:

1. **Navigate to the 'Favorites' tab.**
2. **Browse through your saved articles.**
