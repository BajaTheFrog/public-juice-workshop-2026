# Exercise 06 • Step 3.2

_**Part 3: 🎥 Camera & Time · Feedback · Exercise 3.2**_

Time to add some visual flair and impact with screen effects.

This exercise is a great demonstration of **restraint and contrast**. We use screenshake twice — once for shooting, once for dying — and the difference between them is the whole lesson. If everything shakes equally hard, nothing means anything.

> [!TIP]
>
> Search `[STEP-3.2` to find every comment in this exercise.
> Search `[STEP-3.2.<LETTER>]` to find the `<LETTER>` step.

## FIRST: Enable the exercise

- **FILE**: `game/members/steps.gd`
- **DICTIONARY**: `_supported`

Flip the whole **Exercise 3.2** block from `false` → `true`:

```gdscript
	# --- Exercise 3.2 - Camera & Time / Feedback ---
	SHOOT_SHAKE: true,       # [STEP-3.2.A] Gun Screenshake
	DEATH_SHAKE: true,       # [STEP-3.2.B] Death Screenshake
	SCREEN_FLASH: true,      # [STEP-3.2.C] Death Flash
```

## A. 📺 Gun Screenshake

- **FILE**: `game/content/entities/player_juice_box.gd`
- **CLASS**: `Feedback`
- **FUNCTION**: `on_shot()`

Once the only type of **Juice** the indie community seemed to know about, we finally get to the ever-effective _screenshake_.

We're going to start by applying just a _touch_ of it on every player shot to further drive home the power of the gun and make players feel that action.

As with handling time scaling, we have a special pre-defined manager for screenshake. We pick an amplitude (how _much_ it shakes) and a time (how _long_ it shakes) and let it rip.

Choose modest values here to start — you don't want to make someone sick because they shot too much with a lot of shake!

The function should now read:

```gdscript
	func on_shot(gun: Launcher2D) -> void:
		if not Steps.check(_box, Steps.SHOOT_SHAKE):
			return

		# [STEP-3.2.A]: Make the "gun" feel more powerful with screenshake
		var shake_amplitude: float = 8.0
		var shake_time: float = 0.25
		Game.services.camera.add_shake(shake_amplitude, shake_time)
```

## B. 📺 Death Screenshake

- **FILE**: `game/content/entities/player_juice_box.gd`
- **CLASS**: `Feedback`
- **FUNCTION**: `on_hit()`

We're going to use screenshake _again_ but this time for a different purpose. Like our squash and stretch, you can use it in many ways but you want to be mindful of where and when you are using it and how they contrast with each other.

In this case, we are shaking the screen from dying super hard. We want no ambiguity about what happened.

LeMon is dead and you killed him.
You should make the player really sit with that.

Same shape of change as **A** but **10x the shake and 2x the duration**.

The function should now read:

```gdscript
	func on_hit() -> void:
		Game.services.sound.play_sfx(_box.hurt_sound)

		if not Steps.check(_box, Steps.DEATH_SHAKE):
			return

		# [STEP-3.2.B]: Shake the camera on death
		var shake_amplitude: float = 80.0
		var shake_time: float = 0.5

		Game.services.camera.add_shake(shake_amplitude, shake_time)
```

## C. 📺 Death Flash

- **FILE**: `game/content/contexts/play_context/level_juice_box.gd`
- **CLASS**: `Feedback`
- **FUNCTION**: `async_on_player_died()`

Let's layer _another_ strong visual treatment on top of the shake to really sell the moment with a screen flash.

I find screen flashes to also be the kind of thing that on paper seems like overkill, but when used correctly is a really smart tool.

We'll get a brief edge-to-edge flash of color to decisively punctuate the end of LeMon's life.

Fitting we should end with another `tween`! After all it's one of the best tools in the biz.

We'll pick a `flash_time` and `flash_alpha` (how opaque is the flash) and set them appropriately. A helpful callout here: we'll use `tween.set_ignore_time_scale()` to ensure a slowed-down time_scale doesn't mean a slowed-down flash.

The function should now read:

```gdscript
	func async_on_player_died() -> void:
		if not Steps.check(_box, Steps.SCREEN_FLASH):
			return

		# [STEP-3.2.C]: Full-screen flash to drive impact of death
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
2. Toggle **📺 Gun Screenshake** off and on. Fire away — it should make the kick of the gun feel real without being too distracting.
3. Toggle **📺 Death Screenshake** off and on. Die.
4. Toggle **📺 Death Flash** off and on. Die again.
5. Now die with **all three** on. Note how many things fire at once on that one moment: hitstun, a huge shake, a screen flash, and a sound. That is a death the player cannot possibly miss.

> [!TIP]
>
> Git command to auto-complete this whole exercise: `git checkout step-3.2`.
> See [Git Help & FAQ](14-appendix-git-help.md) for help.
<br>

## 🍎 🍉 🍊 🍋 🍍 🥝 🫐 🍇

### [← Exercise 05 • Step 3.1](05-camera-time-kinetics.md) | [Table of Contents](00-contents.md) | [Part 4 — 🔊 Sound →](06.1-part-4-sound.md)
