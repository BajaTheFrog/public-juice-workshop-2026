# Exercise 02 • Step 1.2

_**Part 1: 🍋 Player Movement · Feedback · Exercise 1.2**_

**Feedback** time!

The movement _feels_ better now, but it doesn't _look_ like anything happened yet. So we'll sell the jump and the landing with a tried-and-true classic: the [squash and stretch](https://en.wikipedia.org/wiki/Squash_and_stretch).

Both effects use **the Tween**. Tweens are an incredibly powerful tool, super easy to use, and at the heart of _lots_ of juicy effects. Some people are saying "all of them."

Check out this _suuuuper_ sick [interactive tween tutorial](https://qaqelol.itch.io/tweens).

> [!TIP]
>
> Search `[STEP-1.2` to find every comment in this exercise.
> Search `[STEP-1.2.<LETTER>]` to find the `<LETTER>` step.

## FIRST: Enable the exercise

- **FILE**: `game/members/steps.gd`
- **DICTIONARY**: `_supported`

Flip the whole **Exercise 1.2** block from `false` → `true`:

```gdscript
	# --- Exercise 1.2 - Movement / Feedback ---
	JUMP_SQUASH: true,       # [STEP-1.2.A] Jump Squash + Stretch
	LAND_SQUASH: true,       # [STEP-1.2.B] Landing Squash + Stretch
```

Everything below happens in **`game/content/entities/player_juice_box.gd`**, in `class Feedback`.

## A. 🍋 Jump Squash + Stretch

- **CLASS**: `Feedback`
- **FUNCTION**: `on_jump_takeoff()`

We'll give the jump a little more life by squashing it down (like loading a spring) and then stretching it vertically (like LeMon is really going for it).

We snap it back to imply some elasticity (probably more than a lemon should have but it's a style choice!)

So let's tween out.

The function should now read:

```gdscript
	func on_jump_takeoff() -> void:
		Game.services.sound.play_sfx(_box.jump_sound)

		if not Steps.check(_box, Steps.JUMP_SQUASH):
			return

		# [STEP-1.2.A]: "Animate" the jump takeoff with some classic squash and stretch
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

`_restart_body_tween()` is just a helper that manages and resets the shared tween between effects. 
You'd probably be fine just making a tween on the spot with `var tween = create_tween()`

## B. 🍋 Landing Squash + Stretch

- **CLASS**: `Feedback`
- **FUNCTION**: `on_landed()`

But it's not just the takeoff! You got to pay attention to the landing too!

Always pay attention to the opportunity to keep actions and reactions balanced and symmetrical! Though not _identical_.

You want the landing to feel different and proportional. So we'll do another type of squash but give it a slightly different treatment. We want it to feel a little stiffer (a quick punch) on landing compared to a jump (which has kind of a wind-up), so we keep the values closer to `1.0`.

The function should now read:

```gdscript
	func on_landed() -> void:
		Game.services.sound.play_sfx(_box.land_sound)

		if not Steps.check(_box, Steps.LAND_SQUASH):
			return

		# [STEP-1.2.B]: Squash on landing to communicate impact
		var squash_amount: Vector2 = Vector2(1.2, 0.8)
		var squash_time: float = 0.06
		var recover_time: float = 0.06

		var tween = _restart_body_tween()
		tween.tween_property(_body_sprite, "scale", body_true_scale * squash_amount, squash_time)
		tween.tween_property(_body_sprite, "scale", body_true_scale, recover_time)
```

## Try it

1. Press **J** for the Juice menu.
2. Toggle **🍋 Jump Squash + Stretch** off and on. Jump with **W** and see the difference!
3. Toggle **🍋 Landing Squash + Stretch** off and on.
4. Try **only** seeing how the jump looks when one is on and the other is off. 

> [!TIP]
>
> Git command to auto-complete this whole exercise: `git checkout step-1.2`.
> See [Git Help & FAQ](14-appendix-git-help.md) for help.
<br>

## 🍎 🍉 🍊 🍋 🍍 🥝 🫐 🍇

### [← Exercise 01 • Step 1.1](01-movement-kinetics.md) | [Table of Contents](00-contents.md) | [Part 2 — 👹 Interactions →](02.1-part-2-interactions.md)
