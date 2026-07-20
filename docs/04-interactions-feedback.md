# Exercise 04 • Step 2.2

_**Part 2: 👹 Interactions · Feedback · Exercise 2.2**_

The interactions _feel_ weightier now. Let's make them **read** better too, with three very simple **Feedback** techniques.

Many of these tips come directly from JW's wonderful talk: _The Art of the Screenshake_. Two of the three effects here are literally just "turn a sprite on for a moment, then turn it off again" — never underestimate how far that gets you.

> [!TIP]
>
> Search `[STEP-2.2` to find every comment in this exercise.
> Search `[STEP-2.2.<LETTER>]` to find the `<LETTER>` step.

## FIRST: Enable the exercise

- **FILE**: `game/members/steps.gd`
- **DICTIONARY**: `_supported`

Flip the whole **Exercise 2.2** block from `false` → `true`:

```gdscript
	# --- Exercise 2.2 - Interactions / Feedback ---
	BIGGER_BULLETS: true,    # [STEP-2.2.A] Bigger Bullets
	MUZZLE_FLASH: true,      # [STEP-2.2.B] Muzzle Flash
	BAT_HIT_FLASH: true,     # [STEP-2.2.C] Bat Hitflash
```

## A. 🍋 Bigger Bullets

- **FILE**: `game/content/objects/player_bullet_juice_box.gd`
- **CLASS**: `Feedback`
- **FUNCTION**: `_apply_bigger_bullet()`

One tip from _The Art of the Screenshake_ is as delightful as it is simple: Just make your bullets bigger.

You aren't making a simulation!
<br>
It doesn't need to "make sense"!
<br>
Get the important stuff IN the player's FACE!

It's easier to track and it feels more powerful. I believe JW says something to the effect of: _"...your bullets should be about the size of your chest."_

Again, this is going to make more sense for some styles of games than others, but the point is to lean into the important pieces of your particular game and draw attention to them.

Dead simple change. We just up the scale.

The function should now read:

```gdscript
	func _apply_bigger_bullet() -> void:
		if not Steps.check(_box, Steps.BIGGER_BULLETS):
			return

		# [STEP-2.2.A]: Increase the size of the bullet (seed) so its more prominent
		_box.body.scale *= 2.0
```

## B. 🍋 Muzzle Flash

- **FILE**: `game/content/objects/player_bullet_juice_box.gd`
- **CLASS**: `Feedback`
- **FUNCTION**: `_async_muzzle_flash()`

A muzzle flash punctuates and confirms to the player that the gun fired and their input was successful. It helps give feedback that would exist IRL but is lost due to the digital nature of the game.

(This is also where haptics are a great solution!)

Another gem of advice from _Art of the Screenshake_: you can get a very cheap muzzle flash effect by just including it in with the bullet sprite and very quickly turning it on before disabling it.

If nothing else it is a great place to start.

We'll apply the same rationale as we did for the shoot spread and randomize our muzzle flash a bit so it feels more chaotic and dynamic.

The function should now read:

```gdscript
	func _async_muzzle_flash() -> void:
		if not Steps.check(_box, Steps.MUZZLE_FLASH):
			return

		# [STEP-2.2.B]: Add muzzle flash to communicate bullet (seed) exit
		var muzzle_flash_time: float = 0.05
		var random_x_scale = Random.randf_range(0.7, 1.2)
		var random_y_scale = Random.randf_range(0.5, 1.1)

		_box.muzzle_sprite.scale = Vector2(random_x_scale, random_y_scale)

		await _async_flash(_box, _box.muzzle_sprite, muzzle_flash_time)
```

`_async_flash()` is already written for you at the bottom of the class but its really simple. It just `visible` parameter on the sprite to be `true` and then `false`.

## C. 👹 Hitflash

- **FILE**: `game/content/entities/bat_juice_box.gd`
- **CLASS**: `Feedback`
- **FUNCTION**: `async_on_hit()`

Pairing nicely with a hitstop is a _hitflash_. This is visual confirmation that our bullet hit and the enemy took damage.

And like the muzzle flash, it's as simple as turning on a sprite for a moment before turning it off again. `bat_juice_box.gd` has its own pre-written `_async_flash()` helper at the bottom of `class Feedback` — this one takes an _array_ of sprites so the whole bat lights up.

What is not captured in the code is that we can get the "full white sprite" effect by using a shader that fully colors a sprite one color. I'm not a shader head but there are lots of good examples out there and it is very simple to implement!

The function should now read:

```gdscript
	func async_on_hit() -> void:
		Game.services.sound.play_sfx(_box.hit_sound)

		if not Steps.check(_box, Steps.BAT_HIT_FLASH):
			return

		# [STEP-2.2.C]: Flash the entire bat to emphasize hit contact
		var hit_flash_time: float = 0.02
		await _async_flash(_box, _box.hit_flash_sprites, hit_flash_time)
```

## Try it

1. Press **J** for the Juice menu.
2. Toggle **🍋 Bigger Bullets** off and on. Hold **Left Mouse Button**.
3. Toggle **🍋 Muzzle Flash** off and on and shoot!
4. Toggle **👹 Hitflash** off and on. Shoot a bat to get that flash.

> [!TIP]
>
> Git command to auto-complete this whole exercise: `git checkout step-2.2`.
> See [Git Help & FAQ](14-appendix-git-help.md) for help.
<br>

## 🍎 🍉 🍊 🍋 🍍 🥝 🫐 🍇

### [← Exercise 03 • Step 2.1](03-interactions-kinetics.md) | [Table of Contents](00-contents.md) | [Part 3 — 🎥 Camera & Time →](04.1-part-3-camera-time.md)
