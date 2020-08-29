# Lecture 7

## Table of Contents
1. Flutter Web App
2. Cross Origin Error
---
## **1. Flutter Web App**
- Using Chrome instead of Simulator to run flutter app
  - Install Chrome if you don't have it
- https://flutter.dev/docs/get-started/web
- Breakdown (in terminal or cmd)
  1. run `flutter channel master` to get the beta version
  2. run `flutter config --enable-web` to enable web mode
  3. run `flutter devices` to check if chrome shows up
  4. go to `Lecture3/lecture_3`
  5. run `flutter create .` to add web support to existing app
  6. run `flutter clean` to clean previous builds
  7. start the app
  8. After launching app in chrome, use `f12` to open inspector, then click `device tool`. Then you will be able to select whichever mobile device you would like
- When restart, refresh the browser instead
---
## **2. XMLHttpRequest Error**
- Browser's `Same Origin Policy`
  - Security mechanism that first web page can access the second web page only if both web pages have the same origin
- Prevents `cross-site request forgery`, an attack by taking advantage of session cookies in the browser

<img src="./same_domain.png" height=150>

- `cookies`: browser saved in your file system, every time you make a http request, the cookie info is passed into as a header
  - contains `session_key` or `session_id` and other info
  - expiration: few hours, 30 days
  - what is `session_key`? unique identifier
    - identifies a particular session, for example when you log in from laptop or iphone, the sessions are different
- A malicious pop up can take advantage of the cookie, so that it gains user information

<img src="./attack.png" height=150>
