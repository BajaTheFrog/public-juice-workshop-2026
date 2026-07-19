# Exercise 03 • Step 2.1

_**Part 2: 👹 Interactions · Kinetics · Exercise 2.1**_

Player movement now feels a bit more interesting! But we aren't just playing in a vacuum, there's other stuff in the game world.

We're going to tune the **Kinetics** to drive home the sense of impact and force — both on the player and on the enemies.

A **hitstop** (or hitstun in certain contexts) adds a _very short_ "freeze" to the game. On paper it seems like doing that would break the flow and experience of the game. In practice, when used carefully, the stop communicates to the player that there was contact! That something happened and it was a big deal.

> [!TIP]
>
> Search `[STEP-2.1` to find every comment in this exercise.
> Search `[STEP-2.1.<LETTER>]` to find the `<LETTER>` step.

## FIRST: Enable the exercise

- **FILE**: `game/members/steps.gd`
- **DICTIONARY**: `_supported`

Flip the whole **Exercise 2.1** block from `false` → `true`:

```gdscript
	# --- Exercise 2.1 - Interactions / Kinetics ---
	DEATH_HITSTUN: true,     # [STEP-2.1.A] Player Hitstun
	BAT_HITSTOP: true,       # [STEP-2.1.B] Bat Hitstun
	SHOOT_KNOCKBACK: true,   # [STEP-2.1.C] Gun Knockback
	SHOOT_SPREAD: true,      # [STEP-2.1.D] Shoot Spread
```

## A. 🍋 Hitstun

- **FILE**: `game/content/entities/player_juice_box.gd`
- **CLASS**: `Kinetics`
- **FUNCTION**: `async_hitstun()`

We're going to start with a hitstop on LeMon.

We're not going to write any of the stoppage code (but we can take a look). Instead we are just going to call some pre-built logic to do so.

And that's it!

The function should now read:

```gdscript
	func async_hitstun() -> void:
		if not Steps.check(_box, Steps.DEATH_HITSTUN):
			return

		# [STEP-2.1.A]: Stun the body to drive home what happened to the player
		var hitstun_time: float = 0.75
		await Game.async_stop(hitstun_time)
```

## B. 👹 Hitstun

- **FILE**: `game/content/entities/bat_juice_box.gd`
- **CLASS**: `Kinetics`
- **FUNCTION**: `async_hitstop()`

Same idea as **A**, but for the enemy. Helping the player understand when their attacks are landing or missing is super important to making the player understand the action and rules of the world.

Virtually the same code. We choose a much shorter hitstop here because we want to keep the action moving — we want to stop _just_ enough to register the impact.

Note the numbers: `0.75` seconds for the player dying versus `0.05` for a bat getting hit. **Big moments get big effects.**

The function should now read:

```gdscript
	func async_hitstop() -> void:
		if not Steps.check(_box, Steps.BAT_HITSTOP):
			return

		# [STEP-2.1.B]: Briefly freeze the whole world to emphasize hit contact
		var hitstop_time: float = 0.05
		await Game.async_stop(hitstop_time)
```

## C. 🍋 Gun Knockback

- **FILE**: `game/content/entities/player_juice_box.gd`
- **CLASS**: `Kinetics`
- **FUNCTION**: `apply_knockback()`

Kinetics is not just the movement you control, it is also how the world pushes _you_ around.

We're going to give our gun(?) some knockback when we fire it. It makes it feel a _lot_ more powerful and adds some nuance to when the player should shoot or not. Now there is a reason to _not shoot_ just as much as there is a reason _to shoot_.

Also it unlocks some cool movement tech in the air.

This is another area where we won't implement the details of the code but can take a look. The idea is simple though: we get the position of where the bullet is coming from and apply some velocity in the opposite direction. That velocity gets spun down over time so we can recover from it.

The function should now read:

```gdscript
	func apply_knockback(gun: Launcher2D) -> void:
		if not Steps.check(_box, Steps.SHOOT_KNOCKBACK):
			return

		# [STEP-2.1.C]: Every shot shoves us off it
		_player.apply_knockback(gun.global_position, _player.knockback_amount)
```

Importantly, our `kinetics` lets `player` actually handle the subtleties of applying and adjusting the knockback over time. The `juice_box` just gets to decide _when_ we call it and with how much knockback.

## D. 🍋 Shoot Spread

- **FILE**: `game/content/entities/player_juice_box.gd`
- **CLASS**: `Kinetics`
- **FUNCTION**: `get_shoot_angle()`

As with all of these changes — there is no one-size-fits-all. It depends on your game and your design goals. But one great way to add some _texture_ and _variety_ to otherwise monotonous interactions is to sprinkle in a little randomness.

So that's what we will do with our shot angle. We're gonna nudge the trajectory a bit up and down at random to make the stream of bullets a bit more interesting to work with!

Sorry hitscan lovers.

1. Normally we just return whatever angle in degrees has been passed into this function.
2. Now we can get a random value between our min (`-_player.shoot_vector_bump`) and our max (`_player.shoot_vector_bump`).
3. Then we just add that to our angle to offset it some!

The function should now read:

```gdscript
	func get_shoot_angle(base_degrees: float) -> float:
		if not Steps.check(_box, Steps.SHOOT_SPREAD):
			return base_degrees

		# [STEP-2.1.D]: Randomize the exit trajectory a bit
		return base_degrees + Random.randf_range(-_player.shoot_vector_bump, _player.shoot_vector_bump)
```

## Try it

1. Press **J** for the Juice menu.
2. Toggle **🍋 Hitstun** off and on. Run into a bat and clock the stop!
3. Toggle **👹 Hitstun** off and on. Shoot a bat and see if you can sense the subtle difference. It's much smaller than the player one — that's on purpose.
4. Toggle **🍋 Gun Knockback** off and on. Hold **Left Mouse Button** and aim wherever. You should feel the knockback pretty clearly and see how it impacts movement. Try shooting downward while airborne.
5. Toggle **🍋 Shoot Spread** off and on. Hold **Left Mouse Button** and watch how the stream of seeds changes.

> [!TIP]
>
> Git command to auto-complete this whole exercise: `git checkout step-2.1`.
> See [Git Help & FAQ](14-appendix-git-help.md) for help.
<br>

## 🍎 🍉 🍊 🍋 🍍 🥝 🫐 🍇

### [← Part 2 — 👹 Interactions](02.1-part-2-interactions.md) | [Table of Contents](00-contents.md) | [Exercise 04 • Step 2.2 →](04-interactions-feedback.md)
