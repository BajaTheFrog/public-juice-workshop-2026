# Step 06 · 2.1.1 — 🍋 Hitstun

_**Part 2: Interactions · Kinetics · 2.1.1 — 🍋 Hitstun**_

A hitstop (or hitstun in certain contexts) adds a _very short_ "freeze" to the game. On paper it seems like doing that would break the flow and experience of the game. 

In practice, when used carefully, the stop communicates to the player that there was contact! That something happened and it was a big deal. 

We're going to start with a hitstop on LeMon.

## Step Changes

> [!TIP]
> 
> Search `[STEP-2.1.1]` to find comments tied to this step. 

### FIRST: Enable `DEATH_HITSTUN` support

- **FILE**: `game/members/steps.gd`
- **DICTIONARY**: `_supported`

Flip **`DEATH_HITSTUN`** from `false` → `true`
```gdscript
	var _supported: Dictionary = {
		...
		DEATH_HITSTUN: true,     # [STEP-2.1.1]
		...
	}
```

### SECOND: Freeze time when the player gets hit (and dies)
- **FILE**: `game/content/entities/player_juice_box.gd`
- **CLASS**: `Kinetics`
- **FUNCTION**: `async_hitstun()`

We're not going to write any of the stoppage code (but we can take a look). Instead we are just going to call some pre-built logic to do so.

And that's it!

The method should now read:

```gdscript
	func async_hitstun() -> void:
		if not Steps.check(_box, Steps.DEATH_HITSTUN):
			return

		# [STEP-2.1.1]: Stun the body to drive home what happened to the player
		var hitstun_time: float = 0.75
		await Game.async_stop(hitstun_time)
```

## Try it

1. Press **J** for the Juice menu.
2. Toggle **🍋 Hitstun** off and on.
3. Get hit (or run into) a bat and clock the stop!
<br>
<br>
> [!IMPORTANT]  
>
> Git command to auto-complete this step: `git checkout step-2.1.1`.
> See [Git Help & FAQ](25-appendix-git-help.md) for help.
<br>

## 🍎 🍉 🍊 🍋 🍍 🥝 🫐 🍇

### [← Part 2 — Interactions](05.1-part-2-interactions.md) | [Table of Contents](00-contents.md) | [Step 07 · 2.1.2 — 👹 Hitstun →](07-bat-hitstun.md)
