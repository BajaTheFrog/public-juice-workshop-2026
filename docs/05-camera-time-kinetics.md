# Exercise 05 • Step 3.1

_**Part 3: 🎥 Camera & Time · Kinetics · Exercise 3.1**_

It's not just controlled actors and other entities that contribute to **Juice** — the context the player experiences it through does as well!

> [!TIP]
>
> Search `[STEP-3.1` to find every comment in this exercise.
> Search `[STEP-3.1.<LETTER>]` to find the `<LETTER>` step.

## FIRST: Enable the exercise

- **FILE**: `game/members/steps.gd`
- **DICTIONARY**: `_supported`

Flip the whole **Exercise 3.1** block from `false` → `true`:

```gdscript
	# --- Exercise 3.1 - Camera & Time / Kinetics ---
	CAMERA_TRACKING: true,   # [STEP-3.1.A] Dynamic Tracking
	DANGER_SLOWMO: true,     # [STEP-3.1.B] Danger Zone Slowmo
```

## A. 📺 Dynamic Tracking

- **FILE**: `game/content/contexts/play_context/level_juice_box.gd`
- **CLASS**: `Kinetics`
- **FUNCTION**: `track_camera()`

As with all of these changes, it depends on your game and intended experience etc etc.

But even a simple game like this can be invigorated with some gentle camera movement that frees it from a locked orientation. We'll do this by adding tracking to the player movement.

In this case we have already written the code to do the work in `_track_player_with_camera()` — it's right below this function if you want to read it — so we can just call it!

The function should now read:

```gdscript
	func track_camera(camera: GameCamera) -> void:
		var camera_center: Vector2 = Game.services.screen.get_screen_center()
		camera.global_position = camera_center

		if not Steps.check(_box, Steps.CAMERA_TRACKING):
			if camera.zoom != camera.standard_zoom:
				camera.zoom = camera.standard_zoom
			return

		# [STEP-3.1.A]: Track the player's position with the camera
		_track_player_with_camera(camera, camera_center)
```

## B. ⏰ Danger Zone Slowmo

- **FILE**: `game/content/entities/player_juice_box.gd`
- **CLASS**: `Kinetics`
- **FUNCTION**: `on_danger_changed()`

Often you will hear people describe great moments of focus or intense action as if "time slowed down" or "time stood still".

Well we can make time _literally_ slow down in tense moments too! This will enhance that experience and make a player super attuned to how close they are to dying.

We have some other logic that is tracking bats and how close they are to measure danger — that arrives here as `closeness`.

Our logic is to slow down time _more_ the closer the nearest bat is, and speed it back up as we get away. By doing this with a `lerp` (the older cousin of a `Tween`) we can make the transition between time scales _super_ smooth.

For `time_scale` management reasons we use a special service to do the actual slowing for us.

The function should now read:

```gdscript
	func on_danger_changed(closeness: float) -> void:
		if not Steps.check(_box, Steps.DANGER_SLOWMO) or closeness <= 0.0:
			Game.services.time.clear_sustained_time(Game.messages.time.danger_zone)
			return

		# [STEP-3.1.B]: As the immediate danger to the player increases, we can slow time
		Game.services.time.set_sustained_time(Game.messages.time.danger_zone, _player, lerpf(1.0, 0.2, closeness))
```

## Try it

1. Press **J** for the Juice menu.
2. Toggle **📺 Dynamic Tracking** off and on. Move around with **A** / **D** to notice the camera movement. 
3. Toggle **⏰ Danger Zone Slowmo** off and on. See how close you can get to a bat!

> [!TIP]
>
> Git command to auto-complete this whole exercise: `git checkout step-3.1`.
> See [Git Help & FAQ](14-appendix-git-help.md) for help.
<br>

## 🍎 🍉 🍊 🍋 🍍 🥝 🫐 🍇

### [← Part 3 — 🎥 Camera & Time](04.1-part-3-camera-time.md) | [Table of Contents](00-contents.md) | [Exercise 06 • Step 3.2 →](06-camera-time-feedback.md)
