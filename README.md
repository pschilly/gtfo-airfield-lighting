# GTFO Airfield Lighting

**Custom airfield lighting assets for DCS World**, created for the **Global Task Force Overlord (GTFO)** community.

GTFO Airfield Lighting provides Mission Editor placeable static objects for building illuminated airfields, forward operating bases, helicopter facilities, and custom runway environments. The pack includes runway and taxiway fixtures, a complete approach-light array, a red/green threshold bar, and parking-area floodlight poles.

## Features

- **Omnidirectional lights:** Elevated and flush-mounted fixtures in blue, white, green, and red.
- **Directional lights:** Elevated fixtures in blue, white, green, and red.
- **Approach-light array:** A single placeable **856 m** approach-light assembly with white and red lights, designed to be viewed from the approach direction.
- **Runway threshold lights:** A single **80 ft (24.384 m)** red/green light bar with shrouded, opposing light heads.
- **Parking floodlight poles:** Area-illumination lamps with a **steady red obstruction beacon** at the top.
- **Mission Editor placement:** Complex assemblies can be positioned as one static object instead of dozens of individual lights.

## Examples

| Name | Preview |
| :--- | :--- |
| Approach Lights | ![Approach Lights](https://cdn.globaltaskforceoverlord.org/airfield-light-mod/Approach%20Lights.png) |
| Directional - Blue | ![Directional - Blue](https://cdn.globaltaskforceoverlord.org/airfield-light-mod/Directional%20-%20Blue.png) |
| Directional - Green | ![Directional - Green](https://cdn.globaltaskforceoverlord.org/airfield-light-mod/Directional%20-%20Green.png) |
| Directional - Red | ![Directional - Red](https://cdn.globaltaskforceoverlord.org/airfield-light-mod/Directional%20-%20Red.png) |
| Directional - White | ![Directional - White](https://cdn.globaltaskforceoverlord.org/airfield-light-mod/Directional%20-%20White.png) |
| Flood Light | ![Flood Light](https://cdn.globaltaskforceoverlord.org/airfield-light-mod/Flood%20Light.png) |
| Omni-Directional - Elevated - Blue | ![Omni-Directional - Elevated - Blue](https://cdn.globaltaskforceoverlord.org/airfield-light-mod/Omni-Directional%20-%20Elevated%20-%20Blue.png) |
| Omni-Directional - Elevated - Green | ![Omni-Directional - Elevated - Green](https://cdn.globaltaskforceoverlord.org/airfield-light-mod/Omni-Directional%20-%20Elevated%20-%20Green.png) |
| Omni-Directional - Elevated - Red | ![Omni-Directional - Elevated - Red](https://cdn.globaltaskforceoverlord.org/airfield-light-mod/Omni-Directional%20-%20Elevated%20-%20Red.png) |
| Omni-Directional - Elevated - White | ![Omni-Directional - Elevated - White](https://cdn.globaltaskforceoverlord.org/airfield-light-mod/Omni-Directional%20-%20Elevated%20-%20White.png) |
| Omni-Directional - Flush - Blue | ![Omni-Directional - Flush - Blue](https://cdn.globaltaskforceoverlord.org/airfield-light-mod/Omni-Directional%20-%20Flush%20-%20Blue.png) |
| Omni-Directional - Flush - Green | ![Omni-Directional - Flush - Green](https://cdn.globaltaskforceoverlord.org/airfield-light-mod/Omni-Directional%20-%20Flush%20-%20Green.png) |
| Omni-Directional - Flush - Red | ![Omni-Directional - Flush - Red](https://cdn.globaltaskforceoverlord.org/airfield-light-mod/Omni-Directional%20-%20Flush%20-%20Red.png) |
| Omni-Directional - Flush - White | ![Omni-Directional - Flush - White](https://cdn.globaltaskforceoverlord.org/airfield-light-mod/Omni-Directional%20-%20Flush%20-%20White.png) |
| Threshold Light Bar - Approach | ![Threshold Light Bar - Approach](https://cdn.globaltaskforceoverlord.org/airfield-light-mod/Threshold%20Light%20Bar%20-%20Approach.png) |
| Threshold Light Bar - Runway End | ![Threshold Light Bar - Runway End](https://cdn.globaltaskforceoverlord.org/airfield-light-mod/Threshold%20Light%20Bar%20-%20Runway%20End.png) |

## Installation — DCS World

### Option 1: Automated Installer (Recommended)

The automated installer is a lightweight (~1 KB) script that automatically detects your DCS installation, downloads or updates the latest GTFO Airfield Lighting assets directly into your DCS Saved Games `Mods\tech` folder, verifies file integrity with Git SHA-1 hashing, and skips files you already have.

1. Download **[`install.bat`](https://raw.githubusercontent.com/pschilly/gtfo-airfield-lighting/master/install.bat)** (or grab it from the repository root / Releases).
2. Save and double-click **`install.bat`** on your PC.
3. Follow the on-screen prompts.

> **Tip:** Keep `install.bat` on your desktop or in your DCS folder and double-click it anytime you want to check for and install new GTFO Airfield Lighting updates!

---

### Option 2: Manual Installation

1. Download a **compiled release** from this repository's **Releases** section (when available) or clone this repository.
2. Extract the `GTFOAirfieldLighting` mod folder into your DCS Saved Games mods directory:

   ```text
   Saved Games\DCS\Mods\tech\GTFOAirfieldLighting\
   ```

   If you use a separate Saved Games profile, such as `DCS.openbeta`, use that profile's folder instead:

   ```text
   Saved Games\DCS.openbeta\Mods\tech\GTFOAirfieldLighting\
   ```
3. Confirm the installed folder contains `entry.lua`, `lights.lua`, `Shapes/` (compiled `.edm` files), and `Textures/`.
4. Restart DCS World.
5. Open the **Mission Editor**, find the GTFO lighting assets among the available **Static Objects**, and place and rotate them to suit your airfield.

**Do not install** the mod inside the DCS World program installation directory. Avoid nesting the mod folder twice, for example `...\GTFOAirfieldLighting\GTFOAirfieldLighting\entry.lua`.

### Updating

Run `install.bat` again for a one-click automated update, or manually replace the installed mod files with those from the new compiled release and restart DCS.

## Troubleshooting

**Objects do not appear in the Mission Editor:** Check that `entry.lua` is directly inside `Saved Games\DCS\Mods\tech\GTFOAirfieldLighting\`, verify that the `Shapes` folder contains the exported EDMs, and restart DCS.

## Credits

Developed for [Global Task Force Overlord (GTFO)](https://globaltaskforceoverlord.org/) and the DCS World community.

DCS World is a product of Eagle Dynamics. This is a community-created mod and is not affiliated with or endorsed by Eagle Dynamics.

## License

```
MIT License

Copyright (c) 2026 Schilly

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```