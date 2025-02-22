# Yoku's Island Express Tracker Package for PopTracker

This a tracker package for PopTracker or other compatible programs to use with the built-in Randomizer mode of [Yoku's Island Express](http://yokugame.com)

Also check out the [Yoku Speedrunning Discord]().

PopTracker can be found [here](https://github.com/black-sliver/PopTracker/releases).

Alternatively, EmoTracker can be found [here](https://emotracker.net). I am unable to test or debug under EmoTracker, but it might just work.

This package, and especially the below instructions, are based on the [Secret of Mana Open World Tracker](https://github.com/Cyb3RGER/SoM-Open-Mode-Tracker). Thanks for the great base.

## Installation

Just download the lastest build and put in your packs folder (as a zip or unpacked, both works).

### PopTracker

For PopTracker the packs folder can be under `USER/Documents/PopTracker/packs`, `USER/PopTracker/packs` or `APP/packs`, where `USER` stands for your user directory and `APP` for the PopTracker installation directory.

### EmoTracker

For EmoTracker the packs folder can be found under `%USERPROFILE%\Documents\EmoTracker\packs`.

## Customization

### PopTracker

To customize location colors, check out [Location Color Key](https://github.com/black-sliver/PopTracker?tab=readme-ov-file#location-color-key)

PopTracker provides a [User Overrides](https://github.com/black-sliver/PopTracker?tab=readme-ov-file#user-overrides) feature. You can override individual files using that.

For example: if you want to change the broadcast layout, you can add your desired layout to the `layout/broadcast.json` file.

## Autotracking

### Archipelago (Server)

If you are playing the [Archipelago based Randomizer](https://git.makuluni.com/Archipelago/YokuArchipelagoMod) autotracking is now supported in PopTracker using the Archipelago protocol. Click "AP" at the top of the window and supply the credentials for the Archipelago slot you want to track.

### UAT (Local)

Code is present for an experimental Universal Autotracker based autotracking for PopTracker. This has the advantage that it runs locally but the current implementation is incomplete. If you want to play with it, edit `manifest.json` to uncomment the `uat` line and run `yoku-autotracker` found there to establish the UAT Bridge, then click UAT at the top of your tracker window. There are probably Perl library dependencies you will need, and I do not have install details.
Autotracking only updates when you touch a checkpoint. I do not recommend using this; consider it highly experimental. A new version is hopefully in the works.
