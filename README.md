# KDE Plasma Luna
Windows Xp Luna theme pack for KDE Plasma

# Features
 - Desktop theme as close as possible to Windows Xp colours/style
 - Custom overriden QML ui files to better adapt to the theme needs
 - HiDpi ready
 - Manually traced the original raster icons to SVGs to create higher resolution ones for HiDpi displays. Used original svgs (with modifications) where found (eg. windows XP flash tour)
 - New icons that Windows Xp did not have, with style close to the original

# Installation
* **Important!** Backup your files before doing anything. We do not hold responsibility for any data loss.
* **Note:** This theme uses modified QML ui files to override certain parts of the desktop apperance. While you use this theme, other themes that use the standard KDE Plasma QML files will not work correctly. If you wish to change theme, disable the UI override (see bellow)
1. Backup your files if anything goes really wrong
2. Install [Kvantum](https://github.com/tsujan/Kvantum)
3. Copy anything inside [home/dot-config](./home/dot-config) to your `~/.config/`
4. Copy anything inside [home/dot-local](./home/dot-local) to your `~/.local/`. **Attention!** If you already have a theme that overrides certain parts of the UI, please back the folders that are about to be replaced (if applicable).
5. Switch your theme to Luna from KDE Settings and the application style to Kvantum
6. Optionaly (not recomended right for now, see [Known Issues](#known-issues)): Edit the file `~/.local/kwin/aurorae/aurorae.qml` and uncomment the line 628 to enable text shadow on the window titles.

# Disabling the UI Override (to use other themes)
1. Rename the `~/.local/kwin/aurorae` folder to something else to prevent KDE Plasma from loading the window decoration override
2. Rename the `~/.local/plasma/plasmoids/` folder to something else to prevent KDE Plasma from loading the plasmoids overrides
3. Rename the `~/.local/plasma/shells/` folder to something else to prevent KDE Plasma from loading the desktop overrides

To revert the above, simply give the folders their original names back.

# Uninstallation
If anything goes wrong (like crashes) or you simply don't want it anymore do the following:

1. Delete folder `~/.local/kwin/aurorae`
2. Delete folder `~/.local/plasma/plasmoids/`
3. Delete folder `~/.local/plasma/shells/`
4. Delete folder `~./local/plasma/desktoptheme/Luna/`
5. Delete folder `~./local/plasma/look-and-feel/Luna/`
6. Delete file `~/.local/color-schemes/Luna.colors`
7. Delete folder `~/.local/icons/Luna/`
8. Delete folder `~/.local/aurorae/themes/Luna/`
9. Delete folder `~/.config/Kvantum/Luna`
10. Uninstall Kvantum if you don't need it

# SVG Icon contribution guide lines
- Use originals 16x16 where possible
- Icons created in svg should be 256x256
- Shadow created by the object duplicated, converted to single curve object (merge) and placed behind
- Shadow for 256x256 is #212121 with 20% blur offset by y: +4, x: +5 from the original object
- Shadow for 16x16 is #212121 with 35% blur offset by y: +10, x: +12 (+6,+7 from the 256x256)
- Store size in 256x256 should be 5.00~5.33px unless some icons need more.

# Known Issues
 - Enabling text shadow on window titles will cause Kwin to enter a crash loop when a window has an emoji on its title. This a known QT [bug](https://bugreports.qt.io/browse/QTBUG-82311)

# Attributions
 - Multiple assets were derived/modified from the [Expose](www.opencode.net/phob1an/expose) theme from Phob1an
 - Decorations were derived/modified from [XBoomer](https://github.com/efskap/XBoomer) from efskap

 # License
GPLv3 to respect freedom and the license of the ones derived