# Oliver's Dotfiles

My dotfiles, _a la_ <http://dotfiles.github.io>.

## Provision a new machine

```shell
cd dotfiles
brew bundle
./scripts/install
```

## Update machine from repo

This installs over existing dotfiles

```shell
cd dotfiles
./scripts/install
brew bundle
brew bundle cleanup --force
```

## Update repo from machine

### Add unlinked dotfiles

For each dotfile in HOME that has a .symlink but is not a
link to that .symlink, update the .symlink and replace the HOME file
by a link to it.

```shell
cd dotfiles
./scripts/ingest
git commit -a 'Update dotfiles'
```

### Add a dotfile

```shell
cd dotfiles
touch home/.rcfile.symlink
./scripts/ingest
git commit -a 'Update dotfiles'
```

This also ingests and commits any other previously non-symlinked files.

### List brews that aren't in the repo

```shell
cd dotfiles
brew bundle cleanup
```

### List casks that aren't in the Brewfile

List apps that weren't installed from a cask or from the Mac App Store.
These are candidates for moving to `Brewfile`.

This script doesn't know about built-in apps such as Mail, or other apps
that don't have casks such as Microsoft Office.

```shell
cd dotfiles
./scripts/caskables
```

### List dotfiles that aren't symlinked to dotfiles/home

```shell
cd dotfiles
./scripts/audit
```
