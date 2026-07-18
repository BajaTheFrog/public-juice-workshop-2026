# Step 05 · 1.2.2 — 🍋 Landing Squash + Stretch

_**Part 1: Movement · Feedback · 1.2.2 — 🍋 Landing Squash + Stretch**_

But its not just the takeoff! You got to pay attention to the landing too! 
Always pat attention to the opportunity to keep actions and reactions balanced and symmetrical! Though not _identical_. 

You want the landing to feel different and proportional. So we'll do another type of squash but give it a slightly different treatment. 

## Where to go
- **FILE**: `game/content/entities/player_juice_box.gd`
- **CLASS**: `Feedback`
- **FUNCTION**: `on_landed()`
- **COMMENT**: `# [STEP-1.2.2]`

### The changes
More Tween action awaits. 

We'll create a `tween` and define another squash scale. We want it to feel a little stiffer (a quick punch) on landing compared to a jump (which has kind of a wind-up), so we keep the values closer to `1.0`. 

The method should now read:

```gdscript
	func on_landed() -> void:
		Game.services.sound.play_sfx(_box.land_sound)

		if not Steps.check(_box, Steps.LAND_SQUASH):
			return

		# [STEP-1.2.2]: Squash on landing to communicate impact
		var squash_amount: Vector2 = Vector2(1.2, 0.8)
		var squash_time: float = 0.06
		var recover_time: float = 0.06

		var tween = _restart_body_tween()
		tween.tween_property(_body_sprite, "scale", body_true_scale * squash_amount, squash_time)
		tween.tween_property(_body_sprite, "scale", body_true_scale, recover_time)
```


## Try it

1. Press **J** for the Juice menu.
2. Toggle **🍋 Landing Squash + Stretch** off and on.
3. Jump with **W** and land: with it on, the lemon gives a satisfying little splat on
   touchdown.
<br>
<br>
> [!IMPORTANT HELP] 
>
> Git command to auto-complete this step: `git checkout step-1.2.2`.
> See [Git Help & FAQ](25-appendix-git-help.md) for help.
<br>

## 🍎 🍉 🍊 🍋 🍍 🥝 🫐 🍇

### [← Step 04 · 1.2.1 — 🍋 Jump Squash + Stretch](04-jump-squash-stretch.md) | [Table of Contents](00-contents.md) | [Part 2 — Interactions →](05.1-part-2-interactions.md)
