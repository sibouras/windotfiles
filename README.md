# windotfiles

windows dotfiles

## Setup

https://www.atlassian.com/git/tutorials/dotfiles

use nushell to run these commands

- Prior to the installation make sure that your source repository ignores the
  folder where you'll clone it, so that you don't create weird recursion problems:

```bash
'.dotfiles' o> .gitignore
```

- Now clone your dotfiles into a bare repository in a "dot" folder of your $HOME:

```bash
git clone --bare git@github.com:sibouras/windotfiles.git $"($env.USERPROFILE)\\.dotfiles"
```

- Define the alias in the current shell scope:

```bash
alias winconfig = git $"--git-dir=($env.USERPROFILE)\\.dotfiles" $"--work-tree=($env.USERPROFILE)"
```

- Checkout the actual content from the bare repository to your $HOME:

```bash
winconfig checkout
```

- Set the flag `showUntrackedFiles` to `no` on this specific (local) repository:

```bash
winconfig config --local status.showUntrackedFiles no
```
