# KDE Plasma Luna
Windows Xp Luna theme pack for KDE Plasma

![KDE Luna Screenshot](./Screenshot-1.jpg)

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
6. (Optional) To switch Start button text to your own, edit to the file `~/.local/share/plasma/plasmoids/org.kde.plasma.kickoff/contents/ui/Kickoff.qml` at line 63 `property string buttonText: "start"`. Change `"start"` to `"your own text"`.
7. (Optional) Iinstall ms fonts (Tahoma, Trebuchet MS, Franklin Gothic)

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
- shadows are applied with Krita layer styles:
 - Colour: either #0d1a33 or #000000
 - Angle 135
- 16x16
 - Content: 14x14
 - Shadow:
  - Distance: 2px
  - Opacity: 90%
  - Size: 2px
- 22x22
 - Content: 21x21
 - Shadow:
  - Distance: 2px
  - Opacity: 90%
  - Size: 2px
- 32x32
 - Content: 30x30
 - Shadow:
  - Distance: 2px
  - Opacity: 90%
  - Size: 2px
- 48x48
 - Content: 46x46
 - Shadow:
  - Opacity: 90%
  - Distance: 2px
  - Size: 2px
- 64x64
 - Content: 61x61
 - Shadow:
  - Opacity: 90%
  - Distance: 2px
  - Size: 3px
- 96x96
 - Content: 93x93
 - Shadow:
  - Opacity: 80%
  - Distance: 3px
  - Size: 4px
- 128x128
 - Content: 122x122
 - Shadow:
  - Opacity: 90%
  - Distance: 3px
  - Size: 4px
- 256x256
 - Content: 246x246
 - Shadow:
  - Opacity: 90%
  - Distance: 5px
  - Size: 8px
- 512x512
 - Content: 496x496
 - Shadow:
  - Opacity: 90%
  - Distance: 12px
  - Size: 16px

- Internal shadows are +0.75 +0.75 23% blur
# Known Issues
 - Emojis are removed from window titles. It causes crashes to Kwin. This a known QT [bug](https://bugreports.qt.io/browse/QTBUG-82311)

# Attributions
 - Multiple assets were derived/modified from the [Expose](https://www.opencode.net/phob1an/expose) theme from Phob1an
 - Decorations were derived/modified from [XBoomer](https://github.com/efskap/XBoomer) from efskap

 # License
GPLv3 to respect freedom and the license of the ones derived
