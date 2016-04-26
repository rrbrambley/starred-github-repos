## About

This simple Swift app uses the Github API (via OctoKit) to fetch the 100 most starred repositories on Github and display the top contributor of each. To do so, it does the following:

1. Uses the search API to fetch the most starred repositories with the request: https://api.github.com/search/repositories?q=stars:>0&sort=stars&per_page=100
2. For each repository, fetches the top contributors with: https://api.github.com/repos/:owner/:repo/contributors

## Nuances

* This project uses a fork of the Objective-C [OctoKit](https://github.com/rrbrambley/octokit.objc) as a git submodule rather than a cocoapod because:
    1. There is no podspec for version 0.7.7, which includes the search functionality
    2. No one had previously written support for fetching contributors for a particular repository.
* Because this app fires off requests to get contributors for every repository returned in the initial repository search request, we need to use authentication so that we can make more than 60 requests per hour (there are 101 requests used to display the data in this app).

## Getting Started

To fetch the code:

1. Run `git clone git@github.com:rrbrambley/starred-github-repos.git`
2. From the root of the repo, `git submodule update --init --recursive`.
3. Run `brew install xctool` (required for next step)
4. Run `./octokit.objc/script/bootstrap` as described [here](https://github.com/octokit/octokit.objc#importing-octokit).
5. Run `pod install` from the root of the StarredGithubRepos Xcode project.
6. Open `StarredGithubRepos.xcworkspace` in Xcode

The client ID and secret are stored in a `Secrets.plist` file in the Xcode project, which is not committed to this repository. Following these instructions to add your own client ID and secret:

1. To get a client ID and client Secret, register an application at https://github.com/settings/applications/new
2. Create a `Secrets.plist` file at the root of the `StarredGithubRepos` group in the Xcode project.
3. Add the keys `GithubClientID` and `GithubClientSecret` to the plist, with values from your newly created application on Github (from step 1)
