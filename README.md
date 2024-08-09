# Pablo L. Guerra's Portfolio Web-App

![Build and Release](https://github.com/plguerradesigns/portfolio/actions/workflows/main.yml/badge.svg)

This web app is a portfolio of my work, projects, and research. </br>
You can find relevant publications, documents, source code, images, videos, and more here.

It is a static web app built using the [Flutter framework](https://flutter.dev/) and hosted on [GitHub Pages](https://pages.github.com/). </br>

You can access the web app here: [https://plguerradesigns.github.io/portfolio](https://plguerradesigns.github.io/portfolio)

<details>
<summary><i><strong> Expand to learn more about Flutter</strong></i></summary>

[![introducing-flutter.png](https://i.postimg.cc/kGfjsky9/introducing-flutter.png)](https://www.youtube.com/watch?v=fq4N0hgOWzU)

Try Flutter directly in your browser using [DartPad](https://dartpad.dev/?id=5c0e154dd50af4a9ac856908061291bc&sample=counter).

[![dart-pad.gif](https://i.postimg.cc/brNDxMJQ/dart-pad.gif)](https://dartpad.dev/?id=5c0e154dd50af4a9ac856908061291bc&sample=counter)

</details>

</br>
<strong>Some notable features include:</strong>

- Dark and light mode, with a toggle button
- A responsive design for portrait and landscape mode
- A list of my
  - educational background
  - professional experiences
  - personal projects
- A custom multi-media player and browser that supports
  - Local videos
  - YouTube videos
  - Local Images
  - Network Images
- Redirects to
  - my social media accounts
  - relevant institutions/organizations/companies
  - the source code of the web app
  - the project issue tracker

## Development Notes

The development of this web app is ongoing and follows an iterative process known as Continuous Integration/Continuous Deployment (CI/CD). </br>

![CI/CD Pipeline](https://www.synopsys.com/glossary/what-is-cicd/_jcr_content/root/synopsyscontainer/column_1946395452_co/colRight/image_copy.coreimg.svg/1663683682045/cicd.svg)

There are three main branches in this repository:

- `master`: The main branch is the default branch and is protected. It contains the latest stable version of the web app.
- `dev`: The development branch is where new features are added and tested. It is merged into the main branch after testing.
- `published`: The published branch contains the latest build of the web app. This branch is used to host the web app on GitHub Pages.

The CI/CD pipeline is implemented using [GitHub Actions](https://github.com/features/actions). The pipeline consists of the following stages:

- Build: The Flutter web app is built using the `flutter build web` command.
- Release: The build artifacts are pushed to the `published` branch.
- Deploy: The `published` branch is deployed to GitHub Pages.

The pipeline is triggered automatically on every commit to the main branch.

## Getting Started

### Install Flutter:

https://docs.flutter.dev/get-started/install

### Run App:

```bash
flutter run
```

### Learn More:

Flutter Documentation:
https://docs.flutter.dev/get-started/learn-more
