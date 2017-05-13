# Oliver's Dotfiles

My dotfiles, _a la_ <http://dotfiles.github.io>.

## Provision a new machine

```shell
cd dotfiles
(cd config && brew bundle)
./scripts/install
```

## Update machine from repo

### Install over existing dotfiles

```shell
cd dotfiles
(cd config && brew bundle)
(cd config && brew bundle cleanup --force)
./scripts/install
```

## Update repo from machine

### Ingest existing dotfiles

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
(cd config && brew bundle cleanup)
```

### List casks that aren't in the Brewfile and could be

```shell
cd dotfiles
./scripts/caskables
```

### List dotfiles that aren't symlinked to dotfiles/home

```shell
cd dotfiles
./scripts/audit
```
