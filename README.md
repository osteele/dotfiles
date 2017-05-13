# Oliver's Dotfiles

My dotfiles, a la <http://dotfiles.github.io>.

## Install over existing dotfiles

```shell
cd dotfiles
./install
```

## Ingest existing dotfiles

```shell
cd dotfiles
./ingest
git commit -a 'Update dotfiles'
```

## Add a file

```shell
cd dotfiles
touch home/.rcfile.symlink
./ingest
git commit -a 'Update dotfiles'
```

This also ingests and commits any other previously non-symlinked files.
