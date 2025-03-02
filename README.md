# Yoku's Island Express Tracker Package for PopTracker

This a tracker package for PopTracker or other compatible programs to use with the built-in Randomizer mode of [Yoku's Island Express](http://yokugame.com)

Also check out the [Yoku Speedrunning Discord](https://discord.gg/Y4JKGHMVkR).

PopTracker can be found [here](https://github.com/black-sliver/PopTracker/releases).

Alternatively, EmoTracker can be found [here](https://emotracker.net). I am unable to test or debug under EmoTracker, but it might just work.

This package, and especially the below instructions, are based on the [Secret of Mana Open World Tracker](https://github.com/Cyb3RGER/SoM-Open-Mode-Tracker). Thanks for the great base.

## Installation

Just download the lastest build and put in your packs folder (as a zip or unpacked, both works).

### PopTracker

For PopTracker the packs folder can be under `USER/Documents/PopTracker/packs`, `USER/PopTracker/packs` or `APP/packs`, where `USER` stands for your user directory and `APP` for the PopTracker installation directory.

### EmoTracker

For EmoTracker the packs folder can be found under `%USERPROFILE%\Documents\EmoTracker\packs`.

## Notes

Access rules are not aware of triggers which might be required to activate the locations, just whether you have the key items necessary. You will have to remember to talk to various NPCs, etc.

While the tracker lets you distinguish between having a Leash and a Sootling on a Leash, the logic currently only cares if you have Leash and the ability to reach the Leash Sootling location in logic. If you get there early somehow and activate your leash those locations will not be marked available.

## Settings

The stacked rectangles with a gear at the top of the PopTracker display opens a Settings window.

  * **Mode**: Select between `Normal` or `Hard` (`Very Hard` is not yet implemented)
    * **Normal**: Any location pointed to by a Tracker is not in logic until that Tracker is found.
    * **Hard**: Trackers are mixed into the normal pool. No skips/glitches are required.

  * **Out of Logic**:
    * **Tracker**: In `Normal` mode, locations for which you do not have a Tracker will be displayed as unreachable (red). Turn this on to instead display them as out of logic (yellow). Has no effect in other modes.

  * **Archipelago**:
    * **Scouting**: (PopTracker) With this option active, locations that you can view but can't reach will display a blue diamond. If you collect the "Scout" item there (represented by an eyeball), a message will be sent to Archipelago to give a free hint for that location. You will need to use an Archipelago client which displays global messages (such as the Text Client) to view it. This is intended to mimic looking at the item in the bubble, for items that display the Archipelago logo. The blue diamond will revert to a blue square once you collect the hint, or be replaced by an appropriately colored square if the location is accessible.
      * In the *Grouped Locations* variant, grouped scout locations will not hide themselves when accessible, sorry.

## Customization

### PopTracker

To customize location colors, check out [Location Color Key](https://github.com/black-sliver/PopTracker?tab=readme-ov-file#location-color-key)

PopTracker provides a [User Overrides](https://github.com/black-sliver/PopTracker?tab=readme-ov-file#user-overrides) feature. You can override individual files using that.

For example: if you want to change the broadcast layout, you can add your desired layout to the `layout/broadcast.json` file.

## Autotracking

### Archipelago (Server)

If you are playing the [Archipelago based Randomizer](https://git.makuluni.com/Archipelago/YokuArchipelagoMod) autotracking is now supported in PopTracker using the Archipelago protocol. Click "AP" at the top of the window and supply the credentials for the Archipelago slot you want to track.

The locations for Leash Sootling (converts Leash to Sootling on a Leash) and Ceremony Instruments are not automatically tracked. You should be able to manually clear those locations or collect those items if you want them displayed.

### UAT (Local)

Code is present for an experimental Universal Autotracker based autotracking for PopTracker. This has the advantage that it runs locally but the current implementation is incomplete. If you want to play with it, edit `manifest.json` to uncomment the `uat` line and run `yoku-autotracker` found there to establish the UAT Bridge, then click UAT at the top of your tracker window. There are probably Perl library dependencies you will need, and I do not have install details.
Autotracking only updates when you touch a checkpoint. I do not recommend using this; consider it highly experimental. A new version is hopefully in the works.
