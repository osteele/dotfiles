#!/bin/bash -eu

# Print applications which could have been installed from Homebrew casks.

app_store_apps () {
  # source: http://osxdaily.com/2013/09/28/list-mac-app-store-apps-terminal/
  find /Applications -path '*Contents/_MASReceipt/receipt' -maxdepth 4 -print | \
    sed 's#.app/Contents/_MASReceipt/receipt#.app#g; s#/Applications/##'
}

cask_apps () {
  brew cask info $(brew cask ls) | perl -lne 'print $1 if /(.*) \(app\)/'
}

non_candidates () {
  (app_store_apps && cask_apps) | sort
}

installed_apps () {
  ls /Applications | grep '.app$'
}

candidates () {
  diff --new-line-format="" --unchanged-line-format="" <(installed_apps) <(non_candidates)
}

candidates
