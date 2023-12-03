# Konsole Session Restore

This is a set of scripts that save and restore Konsole sessions in KDE Plasma.
This is useful in Wayland session because Wayland does not have session restore yet, and Konsole does not support session restore by itself.

Note that the scripts only reopen the windows.
The statuses of the windows (activities, desktop) are not restored.
You can use [kde-window-status-restore](https://github.com/Kelvin-Ng/kde-window-status-restore) to restore the statuses.

## Usage

To save sessions, run

```
./konsole-session-restore-save.sh
```

To restore, run

```
./konsole-session-restore-restore.sh
```

## Related

[kde-window-status-restore](https://github.com/Kelvin-Ng/kde-window-status-restore): A set of scripts that save and restore statuses of windows in KDE Plasma. Can be used together with this script.

