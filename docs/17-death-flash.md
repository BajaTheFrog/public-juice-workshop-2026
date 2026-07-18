# Step 17 · 3.2.3 — 📺 Death Flash

_**Part 3: Camera & Time · Feedback · 3.2.3 — 📺 Death Flash**_

Let's layer _another_ strong visual treatment on top of the shake to really sell the moment with a screen flash. 

I find screenflashes to also be the kind of thing that on paper seems like overkill, but when used correctly is a really smart tool. 

We'll get a brief edge-to-edge flash of color to decisively punctuate the end LeMon's life. 

## Where to go
- **FILE**: `game/content/contexts/play_context/level_juice_box.gd`
- **CLASS**: `Feedback`
- **FUNCTION**: `async_on_player_died()`
- **COMMENT**: `# [STEP-3.2.3]`

## The changes
Fitting we should end with another `tween`! After all it's one of the best tools in the biz. 

We'll pick a `flash_time` and `flash_alpha` (how opaque is the flash) and set them appropriately. A helpful callout here: we'll use `tween.set_ignore_time_scale()` to ensure a slowed-down time_scale doesn't mean a slowed down hit flash. 

The method should now read:

```gdscript
	func async_on_player_died() -> void:
		if not Steps.check(_box, Steps.SCREEN_FLASH):
			return

		# [STEP-3.2.3]: Full-screen flash to drive impact of death
		var flash_time: float = 0.1
		var flash_alpha: float = 1.0

		var tween = _box.flash_rect.create_tween()
		tween.set_ignore_time_scale()
		tween.tween_property(_box.flash_rect, "color:a", flash_alpha, flash_time)
		await tween.finished
		_box.flash_rect.color.a = 0.0
```

## Try it

1. Press **J** for the Juice menu.
2. Toggle **📺 Death Flash** off and on.
3. Die.
<br>
<br>
> [!IMPORTANT HELP] 
>
> Git command to auto-complete this step: `git checkout step-3.2.3`.
> See [Git Help & FAQ](25-appendix-git-help.md) for help.
<br>

## 🍎 🍉 🍊 🍋 🍍 🥝 🫐 🍇

### [← Step 16 · 3.2.2 — 📺 Death Screenshake](16-death-screenshake.md) | [Table of Contents](00-contents.md) | [Part 4 — Sound →](17.1-part-4-sound.md)
