# 3ds.hacks.guide

A complete guide to 3DS (and 2DS) custom firmware, from stock to boot9strap.

https://3ds.hacks.guide/

## Running the site locally with Docker

http://localhost:8080

services:
  guide-3ds:
    image: ghcr.io/wildfirebill-nintendo-3ds/guide_3ds_docker:sha-1f5f1ff
    ports:
      - "8080:80"
    restart: unless-stopped



## Running the site locally

This requires the following installed on your system:
- node.js

To test the website locally, clone the source code:

```sh
git clone https://github.com/hacks-guide/Guide_3DS --recurse-submodules
cd Guide_3DS
```

Then simply run the following commands:

```sh
npm ci
npm run docs:dev
```

The website should now be running on http://127.0.0.1:5173/ (or a port shown on the terminal).
