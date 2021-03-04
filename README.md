# Arch PKGBUILD Test

A Containerfile to test building a PKG, supporting pulling dependencies from the official Arch
repos as well as from the AUR.

It is important to consider not running the container as the root user on the host machine as the
`PKGBUILD` gets sourced and executed within the container. Since `PKGBUILD`s are just Bash scripts,
this is generally a pretty bad idea. Even when running as a non-root user on the host, root is
still used within the container (which is required for `pacman` and installing dependencies).

To build a PKGBUILD, just pass the path to the PKGBUILD locally to the `PKGBUILD` argument, for
example:

```
$ podman build --build-arg "PKGBUILD=./PKGBUILD" .
```

The goal of this repo is to conveniently validate that dependencies are properly specified and
that the project can build. This is not a security tool.
