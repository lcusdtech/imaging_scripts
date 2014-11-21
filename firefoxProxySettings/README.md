Mozilla Firefox Locked Preferences
---------
Add mozilla.cfg and local-settings.js to the following locations, respectively

```
/Applications/Firefox.app/Contents/MacOS/mozilla.cfg
/Applications/Firefox.app/Contents/MacOS/defaults/pref/local-settings.js
```

Extra Encoding
----------
You can optionally encode mozilla.cfg as ROT13 to obscure the contents. This can be done by running the following command:
```
cat /path/to/mozilla.cfg | tr a-zA-Z n-za-mN-ZA-M > /output/path/mozilla.cfg
```
You must also remove the the following line from local-settings.js
```js
pref("general.config.obscure_value", 0);
```
