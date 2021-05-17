# Node.js

Provides utility functions for [Node.js][1], loads the Node Version Manager, and
enables [*npm*][2] completion.

This module must be loaded **before** the *completion* module so that the
provided completion definitions are loaded.

## nodenv

[*nodenv*][5] does one thing well - it is concerned solely with switching
Node versions. It is simple and predictable, Just Works, and is rock solid in
production. nodenv is forked from the popular [*rbenv*][6].

This will be loaded automatically if nodenv is installed in `$NODENV_ROOT`,
*`$XDG_CONFIG_HOME/nodenv`*, *`~/.nodenv`*, or `nodenv` is on the path.

## nvm

[*nvm*][7] allows for managing multiple, isolated Node.js installations in the
home directory.

This will be loaded automatically if nvm is installed in `$NVM_DIR`,
*`$XDG_CONFIG_HOME/nvm`*, *`~/.nvm`*, or is installed with homebrew.

## Variables

- `N_PREFIX` stores the path to [*n*][8] cache.

## Functions

- `node-doc` opens the Node.js online [API documentation][3] in the default
  browser.
- `node-info` exposes information about the Node.js environment via the
  `$node_info` associative array.

## Theming

To display the version number of the current Node.js version, define the
following style inside the `prompt_name_setup` function.

```sh
# %v - Node.js version.
zstyle ':prezto:module:node:info:version' format 'version:%v'
```

Then add `$node_info[version]` to either `$PROMPT` or `$RPROMPT` and call
`node-info` in `prompt_name_preexec` hook function.

## Authors

*The authors of this module should be contacted via the [issue tracker][4].*

- [Sorin Ionescu](https://github.com/sorin-ionescu)
- [Zeh Rizzatti](https://github.com/zehrizzatti)
- [Indrajit Raychaudhuri](https://github.com/indrajitr)

[1]: http://nodejs.org
[2]: http://npmjs.org
[3]: http://nodejs.org/api
[4]: https://github.com/sorin-ionescu/prezto/issues
[5]: https://github.com/nodenv/nodenv
[6]: https://github.com/sstephenson/rbenv
[7]: https://github.com/nvm-sh/nvm
[8]: https://github.com/tj/n
