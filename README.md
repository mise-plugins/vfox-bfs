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

## License

MIT
