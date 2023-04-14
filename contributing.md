# Contributing

Testing Locally:

```shell
asdf plugin test <plugin-name> <plugin-url> [--asdf-tool-version <version>] [--asdf-plugin-gitref <git-ref>] [test-command*]

#
asdf plugin test cyclonedx https://github.com/xeedio/asdf-cyclonedx.git "cyclonedx --version"
```

Tests are automatically run in GitHub Actions on push and PR.
