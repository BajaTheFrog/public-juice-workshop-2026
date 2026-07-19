# Exercise 07 • Step 4.1

_**Part 4: 🔊 Sound · Feedback · Exercise 4.1**_

We've gotten this far and the game feels a lot better. But we are missing a component as important as everything else we have done so far: **sound!**

> [!TIP]
>
> Search `[STEP-4.1.A]` to find the comment tied to this exercise.

## FIRST: Enable the exercise

- **FILE**: `game/members/steps.gd`
- **DICTIONARY**: `_supported`

Flip the **Exercise 4.1** block from `false` → `true`:

```gdscript
	# --- Exercise 4.1 - Sound / Feedback ---
	SOUND_ON: true,          # [STEP-4.1.A] Sound
```

## A. 🔊 Sound

- **FILE**: `game/services/sound_service.gd`
- **FUNCTION**: `play_sfx()`

Unlike every other effect, this one is **not** in a juice box — it's the one global switch that unlocks all of them.

Unlock the sounds 👍.

The top of the function should now read:

```gdscript
func play_sfx(stream: AudioStream, pitch_variance: float = 0.0) -> void:
	# [STEP-4.1.A]: Unlock sounds so they can play!
	var unlocked_sounds = true
	if not Game.steps.on(Steps.SOUND_ON):
		return

	if not unlocked_sounds:
		return
```

## Try it

1. Press **J** for the Juice menu.
2. Toggle **🔊 Sound** off and on.
3. Jump, shoot, hurdle a bat, get hit — wow! It helps! Who could have guessed?

> [!TIP]
>
> Git command to auto-complete this exercise: `git checkout step-4.1`.
> See [Git Help & FAQ](14-appendix-git-help.md) for help.
<br>

## 🍎 🍉 🍊 🍋 🍍 🥝 🫐 🍇

### [← Part 4 — 🔊 Sound](06.1-part-4-sound.md) | [Table of Contents](00-contents.md) | [Wrapping Up →](07.1-wrap-up.md)
