# mruby-app-up

Mruby application hosted on Lambda and deployed with [up](https://github.com/apex/up).

## Setup

```
$ make
```

## Deploy

```
$ up
```

## Notes

The `build` hook in `up.json` simply runs `make`, which ensures that the `./mruby` binary is downloaded and present, Make is used so that this process only happens once.

```json
{
  "hooks": {
    "build": "make"
  }
}
```

The `proxy.command` script is run inside Lambda to start your server. You can think of this as `npm start`, however you'd likely want `npm start` to be `node app.js` for local development. Defining `proxy.command` is strictly for running in production.

```json
{
  "proxy": {
    "command": "./mruby app.js"
  }
}
```

Also note that `./mruby` is placed in .gitignore so it's not checked into GIT. Up will ignore these by default, so we negate it with `!mruby` in .upignore.
