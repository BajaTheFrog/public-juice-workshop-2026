# Step 18 · 4.1.1 — 🔊 Sound

_**Part 4: Sound · Feedback · 4.1.1 — 🔊 Sound**_
Sound is just as important as `tweens` and `screenshake` and hitflases! 

## Where to go

Unlike every other step, this one is **not** in a juice box — it's the one global
switch that unlocks all of them.

- **FILE**: `game/services/sound_service.gd`
- **FUNCTION**: `play_sfx()`
- **COMMENT**: `# [STEP-4.1.1]`

## The changes
Unlock the sounds 👍.

The top of the method should now read:

```gdscript
func play_sfx(stream: AudioStream, pitch_variance: float = 0.0) -> void:
	# [STEP-4.1.1]: Unlock sounds so they can play!
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
<br>
<br>
> [!IMPORTANT]  
>
> Git command to auto-complete this step: `git checkout step-4.1.1`.
> See [Git Help & FAQ](25-appendix-git-help.md) for help.
<br>

## 🍎 🍉 🍊 🍋 🍍 🥝 🫐 🍇

### [← Part 4 — Sound](17.1-part-4-sound.md) | [Table of Contents](00-contents.md) | [Wrapping Up →](18.1-wrap-up.md)
