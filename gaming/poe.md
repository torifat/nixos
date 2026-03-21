# Path of Exile — Steam & Settings Guide

## Steam Launch Options (Properties → Launch Options)

```
gamemoderun %command% --nologo --waitforpreload
```

Do NOT use gamescope — it creates a nested compositor that breaks
Awakened PoE Trade / Exiled Exchange 2 overlays.

## In-Game Settings

- **Display Mode**: Windowed (required for overlay tools to work)
- **Resolution**: Match your monitor's native resolution
- **Renderer**: Vulkan (much better on Linux/Proton)
- **VSync**: Off (VRR + immediate windowrule handles this)
- **Engine Multithreading**: On
- **Dynamic Resolution**: On, target = monitor refresh rate
- **Shader cache**: Let it fully build on first launch (will stutter initially)
