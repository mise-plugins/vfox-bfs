# vfox-bfs

A [vfox](https://github.com/version-fox/vfox) plugin for [bfs](https://github.com/tavianator/bfs) - a breadth-first version of the UNIX find command.

## Requirements

This plugin compiles bfs from source. You need:

- A C compiler (gcc or clang)
- make
- Standard build tools

On Ubuntu/Debian:
```bash
sudo apt-get install build-essential
```

On macOS:
```bash
xcode-select --install
```

## Installation

```bash
mise use vfox:mise-plugins/vfox-bfs@latest
```

Or add to your `mise.toml`:

```toml
[tools]
"vfox:mise-plugins/vfox-bfs" = "latest"
```

## Usage

```bash
# Find files breadth-first
bfs . -name "*.txt"

# Check version
bfs --version
```

## Plugin releases

The Packslip workflow packages only `metadata.lua`, `hooks/`, `lib/`, and `LICENSE`.
The signed manifest describes a portable Lua plugin with no executables; the bfs
version installed by the plugin is independent of the plugin release version.

Every branch push signs and verifies the archive, then installs bfs 4.0.4 through
the extracted plugin on Linux and macOS. These runs retain the archive and signed
packslip as workflow artifacts without publishing a release.

To publish, update `PLUGIN.version` in `metadata.lua` and push the matching
`v<version>` tag. After both platform tests pass, the workflow publishes
`vfox-bfs.tar.gz` and `packslip.sigstore.json` to that tag's GitHub release.

## License

MIT
