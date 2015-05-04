# Fix GrowlVoice

Want to use GrowlVoice without the hassle of manually running a hack each time? Try this simple patch!

This patch does work on OS X 10.10 Yosemite.

Installation instructions:

1. Install [EasySIMBL](https://github.com/norio-nomura/EasySIMBL)
2. Install the patch from the [release list](https://github.com/d235j/GVFixer/releases)

Since I got tired of waiting for Saurik to fix cycript, I decided to reimplement the patch using plain old injection.
This patch utilizes EasySIMBL for injection, but it would be trivial to use a different method instead.

Rather than evaluating the slightly malformed JSON, this patch uses search-and-replace and a regex to fix the formatting.
This means Google could break it pretty easily. If this happens, please file a bug report and I'll make it more robust.


The [ColorfulSidebar](http://cooviewerzoom.web.fc2.com/colorfulsidebar.html) SIMBL plugin was very useful as a template for this.

Fix for 10.10.1 (needs to be re-applied every OS update):
--------------------
1. Close GrowlVoice.
2. Open EasySIMBL.
3. Check "Use SIMBL".
4. Open GrowlVoice.
