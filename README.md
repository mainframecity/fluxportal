# fluxportal

A severely WIP desktop client for the [fluxspace](https://github.com/mainframecity/fluxspace) MUD engine.

### Setup
First, make sure you have **fluxspace** running on `localhost`, then:
```bash
cd fluxportal
yarn
yarn run dev
electron ./main.js
```

**Note:** running `electron ./main.js` doesn't work from within a tmux session.
