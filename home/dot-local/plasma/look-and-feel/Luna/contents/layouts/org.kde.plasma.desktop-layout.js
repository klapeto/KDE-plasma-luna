var plasma = getApiVersion(1);

var layout = {
    "desktops": [
        {
            "applets": [
                {
                    "config": {
                        "/": {
                            "PreloadWeight": "0"
                        }
                    },
                    "geometry.height": 0,
                    "geometry.width": 0,
                    "geometry.x": 0,
                    "geometry.y": 0,
                    "plugin": "org.kde.plasma.calculator",
                    "title": "Calculator"
                },
                {
                    "config": {
                        "/": {
                            "PreloadWeight": "0"
                        },
                        "/ConfigDialog": {
                            "DialogHeight": "480",
                            "DialogWidth": "640"
                        },
                        "/General": {
                            "showSecondHand": "true"
                        }
                    },
                    "geometry.height": 0,
                    "geometry.width": 0,
                    "geometry.x": 0,
                    "geometry.y": 0,
                    "plugin": "org.kde.plasma.analogclock",
                    "title": "Analog Clock"
                }
            ],
            "config": {
                "/": {
                    "ItemGeometriesHorizontal": "Applet-36:1616,304,256,288,0;Applet-42:1648,32,192,176,0;",
                    "formfactor": "0",
                    "immutability": "1",
                    "lastScreen": "0",
                    "wallpaperplugin": "org.kde.image"
                },
                "/ConfigDialog": {
                    "DialogHeight": "540",
                    "DialogWidth": "720"
                },
                "/Configuration": {
                    "PreloadWeight": "0"
                },
                "/General": {
                    "ToolBoxButtonState": "topcenter",
                    "ToolBoxButtonX": "672"
                },
                "/Wallpaper/org.kde.color/General": {
                    "Color": "71,49,102"
                },
                "/Wallpaper/org.kde.image/General": {
                    "Image": "file:///home/mark/Public/irixium_dark/rect3266.png",
                    "SlidePaths": "/usr/share/wallpapers"
                }
            },
            "wallpaperPlugin": "org.kde.image"
        }
    ],
    "panels": [
        {
            "alignment": "center",
            "applets": [
                {
                    "config": {
                        "/": {
                            "immutability": "1"
                        },
                        "/Configuration": {
                            "PreloadWeight": "25"
                        },
                        "/Configuration/General": {
                            "favoritesPortedToKAstats": "true",
                            "systemApplications": "systemsettings.desktop,org.kde.kinfocenter.desktop"
                        },
                        "/Shortcuts": {
                            "global": "Alt+F1"
                        }
                    },
                    "plugin": "org.kde.plasma.kickoff"
                },
                {
                    "config": {
                        "/": {
                            "immutability": "1"
                        },
                        "/Configuration": {
                            "PreloadWeight": "0"
                        }
                    },
                    "plugin": "org.kde.plasma.pager"
                },
                {
                    "config": {
                        "/": {
                            "immutability": "1"
                        },
                        "/Configuration": {
                            "PreloadWeight": "0"
                        },
                        "/Configuration/ConfigDialog": {
                            "DialogHeight": "480",
                            "DialogWidth": "640"
                        },
                        "/Configuration/General": {
                            "launchers": "preferred://browser,preferred://filemanager,applications:org.kde.konsole.desktop",
                            "onlyGroupWhenFull": "false"
                        }
                    },
                    "plugin": "org.kde.plasma.taskmanager"
                },
                {
                    "config": {
                        "/": {
                            "immutability": "1"
                        },
                        "/Configuration": {
                            "PreloadWeight": "0"
                        }
                    },
                    "plugin": "org.kde.plasma.systemtray"
                },
                {
                    "config": {
                        "/": {
                            "immutability": "1"
                        },
                        "/Configuration": {
                            "PreloadWeight": "0"
                        },
                        "/Configuration/Appearance": {
                            "enabledCalendarPlugins": "/usr/lib/qt/plugins/plasmacalendarplugins/astronomicalevents.so,/usr/lib/qt/plugins/plasmacalendarplugins/holidaysevents.so",
                            "showWeekNumbers": "true"
                        },
                        "/Configuration/ConfigDialog": {
                            "DialogHeight": "540",
                            "DialogWidth": "720"
                        }
                    },
                    "plugin": "org.kde.plasma.digitalclock"
                }
            ],
            "config": {
                "/": {
                    "formfactor": "2",
                    "immutability": "1",
                    "lastScreen": "0",
                    "wallpaperplugin": "org.kde.image"
                },
                "/ConfigDialog": {
                    "DialogHeight": "82",
                    "DialogWidth": "1920"
                },
                "/Configuration": {
                    "PreloadWeight": "0"
                }
            },
            "height": 2.625,
            "hiding": "normal",
            "location": "bottom",
            "maximumLength": 120,
            "minimumLength": 120,
            "offset": 0
        }
    ],
    "serializationFormatVersion": "1"
}
;

plasma.loadSerializedLayout(layout);
