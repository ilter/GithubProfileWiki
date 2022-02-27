# GithubProfileWiki iOS Application

This project stands for an app which you can see the list followers of a GitHub user via searching their username on Github. 
- You can see open the profile detail of your follower not only to learn about their repo-gist count, following-follower count and when they joined the GitHub. But also, you can open their GitHub Page via one click on Safari.
- You can add your favorite followers to your favorites list to reach their profile easily. When you decide someone is not your favorite you can remove them too.
- You can search someone from your followers to find the one you are looking for.

<p align="center">
  <img src="https://user-images.githubusercontent.com/37029827/155900553-2325a298-3306-4b9a-a25c-ea287b7117f1.gif" alt="animated" />
</p>


<!-- TABLE OF CONTENTS -->
## Table of contents

* [Tech Stack](#techstack)
* [Getting Started](#gettingstarted)
* [Screen Shots](#screenshots)
* [Roadmap](#roadmap)
* [Contributing](#contributing)
* [Acknowledgments](#acknowledgments)

## Tech Stack

- Swift 5 (iOS 13 Deployment Target)
- MVVM Architectural Pattern
- SPM
- Programmatic UI without Storyboards
- Fully Generic Network Layer with Protocol extensions
- Continuous Integration flows for iOS Builds, SwiftLint with GitHub Actions
- Generic User Defaults Management

<!-- GETTING STARTED -->
## Getting Started

**You should have XCode on your mac to run this project.**
```
It can be build with both XCode 12.5 and XCode 13 
```
**1 - Clone the project**

**2 - Open GithubProfileWiki.xcodeproj with XCode then wait for fetching SPM packages.**

**3 - Build and run**

## Screenshots


<img src="https://user-images.githubusercontent.com/37029827/155894415-b1a8d11e-bb92-45a9-8604-e3e9db13e068.png" width="292.5" height="633"> <img src="https://user-images.githubusercontent.com/37029827/155899428-458fd4d2-a6ee-44cb-8b99-762320fbec94.png" width="292.5" height="633"> <img src="https://user-images.githubusercontent.com/37029827/155894554-735fffe3-1f94-41e5-87a4-838d9b22e1ab.png" width="292.5" height="633">
<img src="https://user-images.githubusercontent.com/37029827/155899427-48a79017-a04f-4304-a2dc-07b22fb9e913.png" width="292.5" height="633"> <img src="https://user-images.githubusercontent.com/37029827/155899486-482165a3-1ca5-49a6-a31f-b9f746321f6c.png" width="292.5" height="633">
<img src="https://user-images.githubusercontent.com/37029827/155899549-e26edfd3-f690-4d84-a54e-2de6e4e5ebd3.png" width="292.5" height="633">

<!-- ROADMAP -->
## Roadmap

- [ ] Improve coverage of Unit Tests
- [ ] Integrate Fastlane for CI with GitHub Actions
- [ ] Improve Network Layer with Async-Await and Combine
- [ ] Create components library with SPM.

See the [open issues](https://github.com/ilter/GithubProfileWiki/issues) for a full list of proposed features (and known issues).

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

<p align="right">(<a href="#top">back to top</a>)</p>



<!-- ACKNOWLEDGMENTS -->
## Acknowledgments

This project is inspired by Sean Allen's course, used its icons and pics on UI. However, codebase and architecture is totally different and improved so if you are following it you should continue to follow the cource until you have finished.
* [Sean Allen](https://seanallen.teachable.com/p/take-home)

<p align="right">(<a href="#top">back to top</a>)</p>
