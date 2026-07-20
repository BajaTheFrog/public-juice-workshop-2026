# Exercise 01 • Step 1.1

_**Part 1: 🍋 Player Movement · Kinetics · Exercise 1.1**_

Movement is the thing the player is _constantly_ interacting with, so it's the first thing worth getting right.

Right now LeMon has very _snappy_ movement: no acceleration, so he changes direction instantaneously and stops on a dime. His jump rises and falls with the same gravity, and he can steer freely in mid-air.

Sometimes that _is_ what you want! It is not inherently wrong. But for the purposes of this workshop we're going to change all three and give the movement some weight, commitment and momentum.

> [!TIP]
>
> Search `[STEP-1.1` to find every comment in this exercise.
> Search `[STEP-1.1.<LETTER>]` to find the `<LETTER>` step.

## FIRST: Enable the exercise

- **FILE**: `game/members/steps.gd`
- **DICTIONARY**: `_supported`

Flip the whole **Exercise 1.1** block from `false` → `true`:

```gdscript
	# --- Exercise 1.1 - Movement / Kinetics ---
	ACCELERATION: true,      # [STEP-1.1.A] Acceleration
	JUMP_GRAVITY: true,      # [STEP-1.1.B] Jump / Fall Gravity
	AIR_DAMPENING: true,     # [STEP-1.1.C] Air Control / Dampening
```

That's what makes these three show up in the Juice menu. Everything below happens in **`game/content/entities/player_juice_box.gd`**.

## A. 🍋 Acceleration

- **CLASS**: `Kinetics`
- **FUNCTION**: `get_acceleration()`

We will introduce acceleration to create a feeling of weight and momentum.

1. `value` gets set to `_player.speed` which happens to be the _max speed_. So there is nothing to build up to, we are just already there.
2. All we are going to do is overwrite `value` with the `_player.acceleration`. This is a lower value that will compound over time until we get to our max speed.

The function should now read:

```gdscript
	func get_acceleration(is_in_air: bool) -> float:
		var value := _player.speed

		if Steps.check(_box, Steps.ACCELERATION):
			# [STEP-1.1.A]: Ease into top speed so the ball carries weight
			value = _player.acceleration

		if Steps.check(_box, Steps.AIR_DAMPENING) and is_in_air:
			# [STEP-1.1.C]: Give up some control in the air
			pass

		return value
```

We'll come back and fill in that second block in **C**.

## B. 🍋 Jump / Fall Gravity

- **CLASS**: `Kinetics`
- **FUNCTION**: `get_gravity_scale()`

One of the clearest examples of the importance of Kinetics is how a jump _feels_. If you are doing a lot of jumping in a game (such as a platformer), your jump better feel great!

It turns out that a jump that rises and falls with the same gravity feels floaty. So we're going to use a classic trick: fall faster than we go up!

1. Without our change, we always return a gravity scale of `1.0`, which means it is constant.
2. However if we check that our `velocity_y` is _greater_ than `0.0`, that means we are falling and can increase the gravity scale with a different value (`_player.fall_gravity_mult`).

The function should now read:

```gdscript
	func get_gravity_scale(velocity_y: float) -> float:
		if not Steps.check(_box, Steps.JUMP_GRAVITY):
			return 1.0

		# [STEP-1.1.B]: Fall faster than we rise
		return _player.fall_gravity_mult if velocity_y > 0 else 1.0
```

`velocity_y > 0` means the LeMon is falling (Godot's Y axis points down), so we only boost gravity on the way *down*.

## C. 🍋 Air Control / Dampening

- **CLASS**: `Kinetics`
- **FUNCTION**: `get_acceleration()` — back where we started in **A**

While it will make sense for some games, we're going to change how in-air movement works. In our case, fully steering in mid-air feels unwieldy and also kind of removes the commitment stakes from the jump.

We're going to "dampen" our acceleration while in air so that you can nudge your position but not fly.

This time we are going to take advantage of `is_in_air`.

1. `value` gets set to `_player.speed` (as before)
2. Our change from **A** updates the value with our acceleration value.
3. _Then_ we will _multiply_ that value by our `player.air_dampening_mult` value. This should be a number between `0.0` and `1.0` where the lower value means less air mobility.

The function now has changes from both **A** and **C**, so this is the finished version of `get_acceleration()`:

```gdscript
	func get_acceleration(is_in_air: bool) -> float:
		var value := _player.speed

		if Steps.check(_box, Steps.ACCELERATION):
			# [STEP-1.1.A]: Ease into top speed so the ball carries weight
			value = _player.acceleration

		if Steps.check(_box, Steps.AIR_DAMPENING) and is_in_air:
			# [STEP-1.1.C]: Give up some control in the air
			value *= _player.air_dampening_mult

		return value
```

## Try it

1. Run the game and press **J** to open the Juice menu.
2. Toggle **🍋 Acceleration** on and off. Roll with **A** / **D**. 
3. Toggle **🍋 Jump / Fall Gravity** on and off. Jump with **W**.
4. Toggle **🍋 Air Control / Dampening** on and off. Try moving left and right in the air. 
5. Now turn **all three** off, then all three on. 

> [!TIP]
>
> Git command to auto-complete this whole exercise: `git checkout step-1.1`.
> See [Git Help & FAQ](14-appendix-git-help.md) for help.
<br>

## 🍎 🍉 🍊 🍋 🍍 🥝 🫐 🍇

### [← Part 1 — 🍋 Player Movement](00.1-part-1-movement.md) | [Table of Contents](00-contents.md) | [Exercise 02 • Step 1.2 →](02-movement-feedback.md)
