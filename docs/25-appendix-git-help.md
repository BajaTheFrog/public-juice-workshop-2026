# Appendix — Git Help & FAQ

**You do not need to know Git to do this workshop.** 
Every step shows you the exact code to type, and the [final source files](20-final-source-player-juice-box.md) have
the complete finished versions to copy-paste.

Git is helpful here to jump around and control changes easily!

If you need a Git hand, however, this file has some guidance. 

## Git real quick

- A **commit** is a saved snapshot of the whole project at a moment in time.
- A **tag** is a friendly name pinned to one snapshot. This workshop has a tag for
  every step: `step-1.1.1`, `step-1.1.2`, … `step-4.1.1`.
- **Checking out** a tag sets every file on disk to match that snapshot.

Because each step builds on the last, the tags are **cumulative**: checking out
`step-2.1.1` gives you the game with *every* step up to and including 2.1.1 already
written. Each step page lists its own tag information as well.

## The one command you actually need

To skip to the finished code for a step, run this in a terminal at the project folder (this example is for `step-1.1.1`):

```bash
git checkout step-1.1.1
```

## FAQ

### **I'm stuck on a step — how do I just skip it?**
Run the `git checkout step-X.Y.Z` command from that step's page.

### **It says:** *"Your local changes would be overwritten by checkout."*
That means you have edits Git doesn't want to throw away without asking. Pick one:

- **Keep your edits for later:** `git stash` (essentially save them for later), then run the `checkout`. Get them back later with `git stash pop`.
- **Throw your edits away and skip:** `git checkout -f step-1.1.1` — the `-f` (force) discards your unfinished changes and jumps straight to the step. Use this when your attempt is broken and you just want the working answer.

### How do I undo my changes to one file and start the step over?

```bash
git restore example/file/path.gd
```

### How do I get back to the very beginning — the clean, unjuiced game?

Check out the branch the workshop started on (your instructor will tell you its name —
it's the "clean slate" with all the steps still empty). If you only want to reset the
files you touched, `git restore <file>` each one, or copy the stubs back from the
instructor's starting point.

### How do I see what I've changed?

- `git status` — which files you've modified.
- `git diff` — the actual line-by-line changes.

## 🍎 🍉 🍊 🍋 🍍 🥝 🫐 🍇

### [← Final Source — `sound_service.gd`](24-final-source-sound-service.md) | [Table of Contents](00-contents.md) | [Appendix — More Resources →](26-appendix-more-resources.md)
