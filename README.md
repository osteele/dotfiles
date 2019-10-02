# Oliver's Dotfiles

My dotfiles, _a la_ <http://dotfiles.github.io>.

This installs files for bash, zsh, and git, and packages for Python, Node.js,
and Homebrew.

Bash uses bash-it.

Both shells install direnv and iTerm 2 integration.

All shell commands below are intended to be run in the dotfiles directory.

## Recipes

### Provision a new machine

```shell
./scripts/install
```

This can also be used after `git pull`, to update a machine that has already
been provisioned. (This isn't necessary if the only changes were to
already-linked dotfiles.)

Warning: This overwrites over existing dotfiles without warning or confirmation.

### Update repo from machine

#### Add unlinked dotfiles

For each dotfile in HOME for which there's a corresponding `dotfiles/home/*`
target, but the HOME dotfile is not a link to that symlink target, update the
dotfiles symlink target, and replace the HOME file by a link to it.

```shell
./scripts/add-dotfiles
git commit -a 'Update dotfiles'
```

#### Add a dotfile

```shell
touch home/.rcfile
./scripts/add-dotfiles
git commit -a 'Update dotfiles'
```

This also ingests and commits any other previously non-symlinked files.

#### List brews that aren't in the repo

```shell
brew bundle cleanup
```

#### List casks that aren't in the Brewfile

List apps that weren't installed from a cask or from the Mac App Store.
These are candidates for moving to `Brewfile`.

This script doesn't know about built-in apps such as Mail, or other apps
that don't have casks such as Microsoft Office.

```shell
./scripts/cask-candidates
```

#### List dotfiles that aren't symlinked to dotfiles/home

```shell
./scripts/dotfile-candidates
```

## Secrets

My `.gitconfig` and `.nprmc` contain secrets. The programs that read these files
don't expand environment variables, so the standard techniques for removing
secrets don't work. And, I don't want to encrypt the whole file, just the
sensitive portions. This repo therefore uses a custom git filter, that smudges
secrets from the macOS Keychain.

Configure a clone of this repository to read secrets from the Keychain thus:

On a new Mac (that doesn't have the secrets in its Keychain): create entries in
the macOS Keychain:

```bash
$ security add-generic-password -U -a $USER -c gitf -C gitf -D 'git filter secret' -l GITHUB_ACCESS_TOKEN  -w …
```

Repeat for `NPM_AUTH_TOKEN` and `NPM_AUTH_SESSION`.

(`NPM_AUTH_SESSION` doesn't really need to be synced on the keychain, but npm
stores it in `.npmrc` and I want to keep it out of the repo, so I'm going to war
with the hammer I've got.)

On a new or old Mac: Tell git to use the filters in this repo; and apply them to
the filtered files:

```bash
git config filter.secrets.smudge './filters/smudge_secrets_filter %f'
git config filter.secrets.clean './filters/clean_secrets_filter %f'
git config diff.secrets.textconv './filters/smudge_secrets_filter %f'
./scripts/resmudge-files
```

Now `git commit` will remove like-named secrets that are in the named in the
`secrets` file, and `git checkout` will add them back.

These filters differ from e.g. <http://git-secret.io> in that (1) these filters
only replace the secret, not the whole file, and (2) these filters completely
remove the secret (relying on its presence in another file), rather than
encrypting it.

This isn't a general-purpose, production-quality, solution. It's just enough to
let me add these files back to my dotfiles repo.

## References

* [What should/shouldn't go in .zshenv, .zshrc, .zlogin, .zprofile, .zlogout?](https://unix.stackexchange.com/questions/71253/what-should-shouldnt-go-in-zshenv-zshrc-zlogin-zprofile-zlogout)
