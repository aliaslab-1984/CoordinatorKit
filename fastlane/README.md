fastlane documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

Install _fastlane_ using
```
[sudo] gem install fastlane -NV
```
or alternatively using `brew cask install fastlane`

# Available Actions
## iOS
### ios bootstrap
```
fastlane ios bootstrap
```
Bootstraps dependencies
### ios lint
```
fastlane ios lint
```
Runs SwiftLint
### ios test
```
fastlane ios test
```
Runs tests
### ios archive
```
fastlane ios archive
```
Builds and archives the specified scheme
### ios deploy_framework
```
fastlane ios deploy_framework
```
Publishes the SDK framework to Artifactory
### ios build_deploy_framework
```
fastlane ios build_deploy_framework
```
Rebuilds the framework and publishes it to Artifactory
### ios sdk_bootstrap
```
fastlane ios sdk_bootstrap
```
Bootstraps SDK dependencies
### ios sdk_test
```
fastlane ios sdk_test
```
Runs SDK tests
### ios sdk_lint
```
fastlane ios sdk_lint
```
Runs SwiftLint for the SDK project

----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
