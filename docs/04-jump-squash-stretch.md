# Step 04 · 1.2.1 — 🍋 Jump Squash + Stretch

_**Part 1: Movement · Feedback · 1.2.1 — 🍋 Jump Squash + Stretch**_

**Feedback** time!

A tried-and-true classic: the [squash and stretch](https://en.wikipedia.org/wiki/Squash_and_stretch). 

We'll give the jump a little more life by squashing it down (like loading a spring) and then stretching it vertically (like LeMon is really going for it). 

We snap it back to imply some elasticity (probably more than a lemon should have but it's a style choice!)


## Where to go
- **FILE**: `game/content/entities/player_juice_box.gd`
- **CLASS**: `Feedback`
- **FUNCTION**: `on_jump_takeoff()`
- **COMMENT**: `# [STEP-1.2.1]`

### The change
An essential tactic (squash and stretch) paired with an essential Godot feature. _The Tween_. 

Tweens are an incredibly powerful tool, super easy to use, and at the heart of _lots_ of juicy effects. Some people are saying "all of them."

Check out this _suuuuper_ sick [interactive tween tutorial](https://qaqelol.itch.io/tweens). 

So let's tween out. 

The method should now read:

```gdscript
	func on_jump_takeoff() -> void:
		Game.services.sound.play_sfx(_box.jump_sound)

		if not Steps.check(_box, Steps.JUMP_SQUASH):
			return

		# [STEP-1.2.1]: "Animate" the jump takeoff with some classic squash and stretch
		var squash_amount: Vector2 = Vector2(1.5, 0.5)
		var stretch_amount: Vector2 = Vector2(0.75, 1.25)
		var squash_time: float = 0.1
		var stretch_time: float = 0.1
		var recover_time: float = 0.2

		var tween = _restart_body_tween()
		tween.tween_property(_body_sprite, "scale", body_true_scale * squash_amount, squash_time)
		tween.tween_property(_body_sprite, "scale", body_true_scale * stretch_amount, stretch_time)
		tween.tween_property(_body_sprite, "scale", body_true_scale, recover_time)
```

`_restart_body_tween()` kills any in-flight squash first, so overlapping jumps and
landings can't fight over the sprite's scale.

## Try it

1. Press **J** for the Juice menu.
2. Toggle **🍋 Jump Squash + Stretch** off and on.
3. Jump with **W** and watch the lemon flatten, stretch, and settle.
<br>
<br>
> [!IMPORTANT HELP] 
>
> Git command to auto-complete this step: `git checkout step-1.2.1`.
> See [Git Help & FAQ](25-appendix-git-help.md) for help.
<br>

## 🍎 🍉 🍊 🍋 🍍 🥝 🫐 🍇

### [← Step 03 · 1.1.3 — 🍋 Air Control / Dampening](03-air-control-dampening.md) | [Table of Contents](00-contents.md) | [Step 05 · 1.2.2 — 🍋 Landing Squash + Stretch →](05-landing-squash-stretch.md)
