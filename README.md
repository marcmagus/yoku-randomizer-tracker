# Yoku's Island Express Tracker Package for PopTracker

This a tracker package for PopTracker or other compatible programs to use with the built-in Randomizer mode of [Yoku's Island Express](http://yokugame.com)

Also check out the [Yoku Speedrunning Discord]().

PopTracker can be found [here](https://github.com/black-sliver/PopTracker/releases).

Alternatively, EmoTracker can be found [here](https://emotracker.net).

This package, and especially the below instructions, are based on the [Secret of Mana Open World Tracker](https://github.com/Cyb3RGER/SoM-Open-Mode-Tracker). Thanks for the great base.

## Installation

Just download the lastest build and put in your packs folder (as a zip or unpacked, both works).

### PopTracker

For PopTracker the packs folder can be under `USER/Documents/PopTracker/packs`, `USER/PopTracker/packs` or `APP/packs`, where `USER` stands for your user directory and `APP` for the PopTracker installation directory.

### EmoTracker

For EmoTracker the packs folder can be found under `USER/Documents/EmoTracker/packs`, where `USER` stands for your user directory.

## Customization

### PopTracker

For Customization in PopTracker just edit the pack's files. Documentation for PopTracker's pack format can be found [here](https://github.com/black-sliver/PopTracker/blob/master/doc/PACKS.md).
For example: if you want to change the broadcast layout, you can add your desired layout to the `layout/broadcast.json` file.
Make sure you have you layout backed up tho, so you don't lose it when you override the file while updating the pack.

### EmoTracker

For Customization in EmoTracker you overwrite the pack's file by placing the file in EmoTracks overrides folder (`USER/Documents/EmoTracker/user_overides`). Good luck finding a documenation for EmoTracker tho :3.

## Autotracking

### Archipelago (Server)

If you are playing the [Archipelago based Randomizer](https://git.makuluni.com/Archipelago/YokuArchipelagoMod) autotracking is now supported in PopTracker using the Archipelago protocol. Click "AP" at the top of the window and supply the credentials for the Archipelago slot you want to track.

### UAT (Local)

Code is present for an experimental Universal Autotracker based autotracking for PopTracker. This has the advantage that it runs locally but the current implementation is incomplete. If you want to play with it, edit `manifest.json` to uncomment the `uat` line and run `yoku-autotracker` found there to establish the UAT Bridge, then click UAT at the top of your tracker window. There are probably Perl library dependencies you will need, and I do not have install details. I do not recommend using this, consider it highly experimental. A new version is hopefully in the works.
