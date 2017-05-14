# Oliver's Dotfiles

My dotfiles, _a la_ <http://dotfiles.github.io>.

All shell commands below are intended to be run in the dotfiles directory.

## Provision a new machine

```shell
brew bundle
./scripts/install
bash ./macos/install.sh
pip install -r requirements.txt
npm install -g
```

## Update machine from repo

Run this after `git pull`, to update a machine that has already been provisioned.
(This isn't necessary if the only changes were to already-linked dotfiles.)

Warning: This overwrites over existing dotfiles without warning or confirmation.

```shell
./scripts/install
brew bundle
brew bundle cleanup --force
```

## Update repo from machine

### Add unlinked dotfiles

For each dotfile in HOME for which there's a corresponding `dotfiles/home/*.symlink` target, but the HOME dotfile is not a
link to that symlink target, update the dotfiles symlink target, and replace the HOME file
by a link to it.

```shell
./scripts/add-dotfiles
git commit -a 'Update dotfiles'
```

### Add a dotfile

```shell
touch home/.rcfile.symlink
./scripts/add-dotfiles
git commit -a 'Update dotfiles'
```

This also ingests and commits any other previously non-symlinked files.

### List brews that aren't in the repo

```shell
brew bundle cleanup
```

### List casks that aren't in the Brewfile

List apps that weren't installed from a cask or from the Mac App Store.
These are candidates for moving to `Brewfile`.

This script doesn't know about built-in apps such as Mail, or other apps
that don't have casks such as Microsoft Office.

```shell
./scripts/cask-candidates
```

### List dotfiles that aren't symlinked to dotfiles/home

```shell
./scripts/dotfile-candidates
```

## Secrets

My `.gitconfig` and `.nprmc` contain secrets. The programs that read these files don't expand environment variables, so the standard techniques for removing secrets don't work.

Create a file `.git/config/secrets` with lines like this:

    # .gitconfig
    accesstoken = ...

    # .npmrc
    _auth="..."
    AuthSession=...

where the ... are the secrets from the respective files.

Then add this section to `.git/config`:

```bash
cat > .git/config
[filter "secrets"]
    smudge = ./filters/smudge_secrets_filter
    clean = ./filters/clean_secrets_filter
```

Now `git commit` will remove like-named secrets that are in the named in the `secrets` file, and `git checkout` will add them back.

These filters differ from e.g. <http://git-secret.io> in that (1) these filters only replace the secret, not the whole file, and (2) these filters completely remove the secret (relying on its presence in another file), rather than encrypting it.

This is very far from a general-purpose industrial-strength solution. It's just enough to let me add these files back to my dotfiles repo.
