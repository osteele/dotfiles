# Oliver's Dotfiles

My dotfiles, a la <http://dotfiles.github.io>.

## Install over existing dotfiles

```shell
cd dotfiles
./scripts/install
```

## Ingest existing dotfiles

```shell
cd dotfiles
./scripts/ingest
git commit -a 'Update dotfiles'
```

## Add a file

```shell
cd dotfiles
touch home/.rcfile.symlink
./scripts/ingest
git commit -a 'Update dotfiles'
```

This also ingests and commits any other previously non-symlinked files.

## List dotfiles that aren't symlinked to dotfiles/home

```shell
cd dotfiles
./scripts/audit
```
