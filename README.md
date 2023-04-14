<div align="center">

# asdf-cyclonedx [![Build](https://github.com/xeedio/asdf-cyclonedx/actions/workflows/build.yml/badge.svg)](https://github.com/xeedio/asdf-cyclonedx/actions/workflows/build.yml) [![Lint](https://github.com/xeedio/asdf-cyclonedx/actions/workflows/lint.yml/badge.svg)](https://github.com/xeedio/asdf-cyclonedx/actions/workflows/lint.yml)


[cyclonedx](https://cyclonedx.org) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

**TODO: adapt this section**

- `bash`, `curl`, `tar`: generic POSIX utilities.
- `SOME_ENV_VAR`: set this environment variable in your shell config to load the correct version of tool x.

# Install

Plugin:

```shell
asdf plugin add cyclonedx
# or
asdf plugin add cyclonedx https://github.com/xeedio/asdf-cyclonedx.git
```

cyclonedx:

```shell
# Show all installable versions
asdf list-all cyclonedx

# Install specific version
asdf install cyclonedx latest

# Set a version globally (on your ~/.tool-versions file)
asdf global cyclonedx latest

# Now cyclonedx commands are available
cyclonedx --version
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/xeedio/asdf-cyclonedx/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Sean Williams](https://github.com/xeedio/)
