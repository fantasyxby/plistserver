# plistServer-free
A Rust server used for QuickSign to serve install manifests under HTTPS (as required by iOS)

This is licensed under the GPLv3 so you are free to use this anywhere (as long as it's under the GPLv3) under the terms of the GPLv3

## How to run
### Method 1: Using Rust
1. Make sure you have [Rust](https://www.rust-lang.org/tools/install) installed.
2. Go into the server's cloned directory, and simply run `cargo run`

### Method 2: Using Docker
You can run this server using Docker:

```bash
docker run -p 3788:3788 ghcr.io/[your-github-username]/plistserver:latest
```

Or build it yourself:

```bash
docker build -t plistserver .
docker run -p 3788:3788 plistserver
```

## Usage
The server provides an endpoint `/genPlist` that generates iOS app install manifests.

Example:
```
http://your-server:3788/genPlist?bundleid=com.example.app&name=ExampleApp&version=1.0&fetchurl=https://example.com/app.ipa
```

## Credits
plistServer was originally written by the QuickSign team.
[Source](https://github.com/QuickSign-Team/plistserver)
[c22dev](https://github.com/c22dev)
[boredcoder411](https://github.com/boredcoder411)
