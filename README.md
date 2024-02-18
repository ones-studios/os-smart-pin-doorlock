# Smart Pin Doorlock

A description of your project

## Finish setup

- [ ] Set up local build
- [ ] Set up GitHub restrictions
- [ ] Add it to the container
- [ ] Additional tool using scripts

### Local builds

#### Get a PAT

1. Head to https://github.com/settings/tokens and create a token with `repo` and `packages` scope
2. Make sure this token is authorised to access `discovery-ltd` repositories

#### iOS - Access token

Open `~/.netrc` and add the PAT you just created:

```
machine api.github.com
login YOUR_GITHUB_USERNAME
password YOUR_GITHUB_PERSONAL_ACCESS_TOKEN
```

On some versions of MacOS, the default permissions of the netrc file may give you issues. In that case, fix the perms by running

```
chmod 600 .netrc
```

#### iOS - dev tools

**Ruby/Cocoapods:** Like most iOS projects, ours also make use of Cocoapods. Find install instructions [here](https://guides.cocoapods.org/using/getting-started.html)

**git-lfs:** Some of the repo's use git-lfs to wrangle large files. Install this using `brew install git-lfs`


#### Android - access token

Using the same PAT you used in the iOS setup, open `~/.gradle/gradle.properties` and add two new properties:

```properties
mavenUsername=YOUR_GITHUB_USERNAME 
mavenPassword=YOUR_GITHUB_PERSONAL_ACCESS_TOKEN
```

#### Android - build tools

**Android SDK:** the easiest is to install this via Android Studio

**Android Studio:** Download and install the latest version. Be prepared for Flutter to download half the internet.


### GitHub restrictions

1. Set up branch protections rules for `master`
   - Require pull request before merging
   - Require approvals (2)
   - Require status checks to pass before merging
   - Require branches to be up to date before merging
   - Do not allow bypassing the above settings
2. Enable dependabot alerts (in the Security tab)


### Add it to the container

In the container, add the project to the `dependencies`.

```yaml
...
dependencies:
  ...
  smart_pin_doorlock:
    git:
      url: git@github.com:discovery-ltd/os-smart-pin-doorlock-flutter.git
      path: smart_pin_doorlock
      ref: <latest version>
```
