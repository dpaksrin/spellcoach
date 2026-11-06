# SpellCoach: Setup Guide

SpellCoach is a single file, `SpellCoach.html`. It tracks which spelling word lists your son has studied and quizzed, and when. Progress is saved to a JSON file that keeps the last 10 versions.

## Files

| File | What it is |
|---|---|
| `SpellCoach.html` | The app. Double-click it to play. |
| `Word List Name.txt` | The list of word sets. |
| `build.ps1` | Rebuilds `SpellCoach.html` after you edit `Word List Name.txt`. |
| `src\SpellCoach.template.html` | The app source that `build.ps1` uses. |
| `spellcoach-progress.json` | The save file. It is created after you connect a save folder. |
| `spellcoach-progress.bak.json` | A copy of the previous save, kept as a safety net. |

If a folder still has an older `brickquest-progress.json` from before the rename, the app reads it automatically and saves to `spellcoach-progress.json` from then on.

## Windows PC (Microsoft Edge or Google Chrome)

1. Double-click `SpellCoach.html`. If it opens in another browser, right-click it and choose **Open with > Microsoft Edge**.
2. Tap **Parents** and create a 4-digit parent PIN.
3. Under **Save file**, tap **Connect Save Folder** and pick a folder.
   - To share progress with the iPad, pick a **OneDrive** folder (for example `OneDrive\SpellCoach`).
   - Click **Allow** when Edge asks to let the site edit files.
4. From then on, every change saves to `spellcoach-progress.json` automatically.
5. When you reopen the app later, Edge may show a **Tap to reconnect save** button at the top. Tap it once and click **Allow**.

Tip: in Edge, open the file and choose **... > Apps > Install this site as an app** to get a desktop icon.

## iPad

iPad Safari cannot run a web app from a local file or write files by itself, so put `SpellCoach.html` on a free website. Your progress still stays on the iPad. The website only delivers the app.

### Where the app lives online

The app is published at **https://dpaksrin.github.io/spellcoach/** from the public repository https://github.com/dpaksrin/spellcoach.

- Only the app files are in the repository. Never upload `spellcoach-progress.json` there, because anyone could read it.

### On the iPad

1. Open https://dpaksrin.github.io/spellcoach/ in Safari.
2. Tap **Share > Add to Home Screen**. SpellCoach now opens like a normal app.
3. Progress saves automatically on the iPad.

## Syncing progress with JSONBin.io

1. Create a JSONBin bin and make it public. SpellCoach does not store API credentials, so private bins are not supported.
2. In SpellCoach, open **Parents > JSONBin.io sync**, paste the bin ID or its `https://api.jsonbin.io/v3/b/...` URL, and choose **Connect & sync**.
3. Use the same bin ID on each device. SpellCoach saves changes automatically and checks for newer progress when it opens or returns to the foreground.

Anyone who knows the public bin ID may be able to read or overwrite its contents. Do not use this option for sensitive data. If devices have different progress, the more recently saved progress is used and the other copy is kept in version history.

## Moving progress between the PC and the iPad

Use one device at a time: finish on one, save, then open on the other.

- **PC to iPad:** on the PC, progress is already in `spellcoach-progress.json` in your OneDrive folder. On the iPad, open **Parents > Open from Files** and pick that file from OneDrive (or iCloud Drive).
- **iPad to PC:** on the iPad, open **Parents > Save to Files** and save `spellcoach-progress.json` into the same OneDrive folder, replacing the old file. The PC loads it automatically the next time the app opens or comes back into view.
- If you open a file that is **older** than the progress already on the device, the app warns you first. Whatever you choose, the current progress is kept as a version you can restore.

## Versions and undo

- Every change (a set marked, a quiz score, a style or settings change, a parent edit) creates a new version. The save file keeps the **10 most recent** versions.
- After marking a set, your son can tap **Oops, I tapped by mistake** to undo it.
- In **Parents > Versions**, tap **Restore** on any version. Restoring also creates a version, so a restore can be undone.
- Ten versions cover about the last ten actions. For a longer history, tap **Save to Files** every week to keep a dated backup copy.

## Adding progress done before the app

Go to **Parents** and turn on **edit mode**. Then:
- Open any set to add a past "studied" or "quiz" entry with its date, change a date or score, or delete a mistake.
- Open a zone on the map and use **Mark all studied** to mark every not-started set in that zone as studied on one date.

## Updating the word lists

1. Edit `Word List Name.txt` (one list name per line).
2. In PowerShell, run `.\build.ps1` from this folder.
3. Upload the new `SpellCoach.html` to https://github.com/dpaksrin/spellcoach (**Add file > Upload files**). The iPad picks it up within a few minutes.

On the PC, new names in `Word List Name.txt` inside the connected save folder are also picked up automatically.

## How it scores (for parents)

| Action | Studs |
|---|---|
| Study a set (once per set per day) | +10 |
| Take a quiz (once per set per day) | +20, plus +10 if 80% or higher |
| Reach the daily goal | +25 bonus |
| Earn a Gold Brick | +50 |

- **Three bricks per set:** Studied, then Quiz passed (80% or higher), then Gold Brick (pass the quiz again at least 7 days after the first pass). The Gold Brick builds spaced review into the game.
- **Studs are never taken away.**

## Forgot the parent PIN?

Open `spellcoach-progress.json` in Notepad, find `"pinHash"` in the `"current"` section, change its value to `""`, and save. The next time you tap **Parents**, the app asks you to create a new PIN.
