# afpfs-ng-deb

Compile [afps-ng](https://github.com/simonvetter/afpfs-ng) into a Debian (.deb) package.

afpfs-ng / libafpclient is an open source client for the Apple Filing Protocol.

## Purpose

afpfs-ng is no longer packaged in Debian, but it remains useful - for example, [to mount Apple Time Capsule shares](https://rafaelc.org/posts/mounting-airport-time-capsule-on-linux-in-2025/).

This repository provides a clean and reproducible way to build afpfs-ng inside a Docker container and generate a .deb package for easy installation.

## Requirements

- Docker
- Make

## Usage

To build the package, run:

```bash
make
```

The deb will be available in the `./dist` directory.

## Installing the package

```bash
sudo apt install ./dist/<name_of_file>.deb
```

## Releases

If you don't want to build it yourself, pre-built ARM64 deb packages are available on [Releases](https://github.com/rc2dev/afpfs-ng-deb/releases).

## License

Licensed under [GPLv3](LICENSE)

Copyright (C) 2025 [Rafael Cavalcanti](https://rafaelc.org/dev)
