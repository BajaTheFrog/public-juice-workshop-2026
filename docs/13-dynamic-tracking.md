# Step 13 · 3.1.1 — 📺 Dynamic Tracking

_**Part 3: Camera & Time · Kinetics · 3.1.1 — 📺 Dynamic Tracking**_

As with all of these changes, it depends on your game and intended experience etc etc. 

But even a simple game like this can be invigorated with some gentle camera movement that frees it from a locked orientation.  

We'll do this in our game by adding tracking to the player movement.

## Step Changes

> [!TIP]
> 
> Search `[STEP-3.1.1]` to find comments tied to this step. 

### FIRST: Enable `CAMERA_TRACKING` support

- **FILE**: `game/members/steps.gd`
- **DICTIONARY**: `_supported`

Flip **`CAMERA_TRACKING`** from `false` → `true`
```gdscript
	var _supported: Dictionary = {
		...
		CAMERA_TRACKING: true,   # [STEP-3.1.1]
		...
	}
```

### SECOND: Track the player with the camera
- **FILE**: `game/content/contexts/play_context/level_juice_box.gd`
- **CLASS**: `Kinetics`
- **FUNCTION**: `track_camera()`

In this case we have already written the code to do the work in `_track_player_with_camera`, so we can just call it!

The method should now read:

```gdscript
	func track_camera(camera: GameCamera) -> void:
		var camera_center: Vector2 = Game.services.screen.get_screen_center()
		camera.global_position = camera_center

		if not Steps.check(_box, Steps.CAMERA_TRACKING):
			if camera.zoom != camera.standard_zoom:
				camera.zoom = camera.standard_zoom
			return

		# [STEP-3.1.1]: Track the player's position with the camera
		_track_player_with_camera(camera, camera_center)
```

## Try it

1. Press **J** for the Juice menu.
2. Toggle **📺 Dynamic Tracking** off and on.
3. Move around with **A** / **D**.
<br>
<br>
> [!IMPORTANT]  
>
> Git command to auto-complete this step: `git checkout step-3.1.1`.
> See [Git Help & FAQ](25-appendix-git-help.md) for help.
<br>

## 🍎 🍉 🍊 🍋 🍍 🥝 🫐 🍇

### [← Part 3 — Camera & Time](12.1-part-3-camera-time.md) | [Table of Contents](00-contents.md) | [Step 14 · 3.1.2 — ⏰ Danger Zone Slowmo →](14-danger-zone-slowmo.md)
