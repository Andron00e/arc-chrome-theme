# arc-chrome-theme

Arc-style spaces, colors and Cmd+T for Chrome and other Chromium browsers, as patches for two open-source extensions:

- [Arcify](https://github.com/nisargkolhe/arcify): adds a color editor for each space (any color, gradients, light/dark/auto, intensity, grain), synced through your browser account.
- [Arcify Spotlight](https://github.com/phulsechinmay/arcify-spotlight): Cmd+T lists open tabs by recent use.

## Install

```bash
git clone https://github.com/Andron00e/arc-chrome-theme.git
cd arc-chrome-theme
./scripts/build.sh   # needs git, node, openssl
```

In `chrome://extensions`, turn off the Web Store versions, enable Developer mode, then **Load unpacked** `dist/arcify` and `dist/arcify-spotlight`.

## Shortcuts

Suggested Arc-like keys, set in `chrome://extensions/shortcuts` (use Ctrl instead of ⌘ on Windows and Linux):

| Command | Key |
|---|---|
| Spotlight --> New Tab | ⌘T |
| Spotlight --> Current Tab URL | ⌘L |
| Arcify --> Toggle side panel | ⌘S |
| Arcify --> Quick Pin/Unpin Tab | ⌘D |
| Arcify --> Next / prev tab in space | ⌥⌘↓ / ⌥⌘↑ |
| Arcify --> Copy current tab URL | ⇧⌘C |

## Colors

Open a space's **⋯** menu, then **Custom Color…**. To show spaces as tab groups, turn on **Sync spaces to Chrome tab groups** in Arcify's settings.

## Notes

- `keys/*.pem` gives Arcify a fixed ID so colors sync across computers. Keep it private; git ignores it.
- Only the sidebar is colored: extensions can't theme the browser toolbar.
- The original projects are git submodules in `vendor/`. To update one, check out a newer commit there, refresh its patch in `patches/` if it no longer applies, and rebuild.

## License

GPL-3.0, like both upstream projects.
