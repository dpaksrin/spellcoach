# SpellCoach

A brick-building game that helps a young speller track spelling bee word lists. It records each list he studies and each quiz he takes, with the date.

- Works as a single HTML file, with no install and no server.
- Five themes (Brick City, Space Base, Knight's Castle, Chess Kingdom, Deep Sea Dive) and a choice of colors.
- Daily goals, studs, streaks, a calendar, and Gold Bricks for passing a review quiz a week later.
- Progress saves to a JSON file that keeps the last 10 versions for undo and restore.
- A Parent Corner behind a PIN.

## Play

- **Online (iPad or any browser):** https://dpaksrin.github.io/spellcoach/
- **On a Windows PC:** download `SpellCoach.html` and open it in Microsoft Edge or Google Chrome.

Progress is stored only on the device or in the save file you choose. It never goes to this repository.

See [Setup-Guide.md](Setup-Guide.md) for PC setup, iPad setup and moving progress between them.

## Files

| File | Purpose |
|---|---|
| `SpellCoach.html` | The app, built from the template with the word lists embedded |
| `index.html` | Opens `SpellCoach.html` on GitHub Pages |
| `src/SpellCoach.template.html` | App source |
| `build.ps1` | Rebuilds `SpellCoach.html` from the template and `Word List Name.txt` |
| `Word List Name.txt` | The word list names |
| `Setup-Guide.md` | Setup and how-to guide for parents |

## Update the word lists

Edit `Word List Name.txt`, run `.\build.ps1` in PowerShell, then commit the new `SpellCoach.html`.
