# Risflecting
Website + internal communication plattform for the risflecting team.

## Issue with 'therubyracer' gem
If you pull the source and try a clean install on OSX 10.10 there presumeably will be an issue with 'therubyracer' gem (version 0.10.2).
Looks like the default gcc compiler causes this problem. To solve it, follow these instructions:
```
brew tap homebrew/dupes
brew install apple-gcc42

export CC=/usr/local/Cellar/apple-gcc42/4.2.1-5666.3/bin/gcc-4.2
export CXX=/usr/local/Cellar/apple-gcc42/4.2.1-5666.3/bin/g++-4.2
export CPP=/usr/local/Cellar/apple-gcc42/4.2.1-5666.3/bin/cpp-4.2

brew uninstall v8
gem uninstall libv8
```
Source: http://stackoverflow.com/a/20145328
