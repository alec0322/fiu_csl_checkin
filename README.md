# FIU CSL Check-in
iOS and Android IoT management system to manage devices within the Cyber-Physical Systems Security Lab (CSL) at FIU.

## Prerequisites 

- **Flutter**: https://docs.flutter.dev/get-started/install/windows/mobile
- **Git**: https://gitforwindows.org/
    - Version 2.4 or later
- **Android Studio**: https://developer.android.com/studio/archive 
    - Version 2022.3.1 Patch 4 (Android Studio Giraffe)
    - Make sure to leave Android Virtual Device checked during installation, as it will be used for debugging.
        - It is likely that the wizard will tell you to install Intel HAXM, but the SDK should do it for you: ignore the error message and press 'finish'
- **IDE of your choice**
    - VS Code

## Git Guide and Bash Commands

I highly recommend referring to this guide for any definitions or questions: https://rogerdudler.github.io/git-guide/.

As for the following commands, they are meant to be used in **Git Bash**.

#### Cloning the repository

Go to any local directory of your choice and then run:
```
git clone https://github.com/alec0322/fiu_csl_checkin
```

#### Creating a branch

```
git checkout -b <my-new-branch>
```
You can name a branch anything you want, but generally you should follow common naming conventions, for example:
```
git checkout -b feature/new-login-page
git checkout -b bugfix/fix-login-issue
```

#### Add files to a branch

The following command...
```
git add .
```
will add all of your local repo files into your branch

For a small project such as this one it would be fine to add all of your local files to your branch, but it is best to only add the files you have changed:
```
git add <file-name>
```

#### Commit changes

Once you've added the altered files to a branch, to actually commit these changes use:
```
git commit -m <my-commit-message>
```

#### Push changes

After committing, your changes have to be pushed into the remote repository, when pushing into a branch for the first time use:
```
git push --set-upstream origin 
```
If you have pushed into said branch previously...
```
git push
```
will work just fine.

After you push, Git Bash will return a link pointing to the **pull request (PR)** on GitHub. Then, follow the link, submit your PR, and you're done!

In general, as long as you always create new branches for any changes you make and don't push into main directly you shouldn't run into any issues.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

#### Run the application

Go into the directory in which you cloned the repo and run:
```
flutter run
```
Once you have Android Studio set up, this command will launch the Android Virtual Device emulator and display the application.
