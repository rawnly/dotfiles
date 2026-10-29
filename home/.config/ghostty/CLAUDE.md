# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Ghostty terminal emulator configuration repository containing user settings, themes, and custom shaders.

## Repository Structure

- `config` - Main Ghostty configuration file with terminal settings, keybindings, fonts, and appearance options
- `themes/` - Color scheme files for terminal themes (e.g., astrodark, catppuccin-mocha, carbonfox)
- `shaders/` - GLSL shader files for visual effects (animated gradients, CRT effects, retro terminal styles)

## Configuration Management

### Main Config File

The `config` file uses Ghostty's configuration format with key-value pairs. Important sections include:

- Theme selection (currently using oh-lucy-evening)
- Font configuration (Zed Plex Mono, size 18)
- Window and padding settings
- Keybindings for tabs, splits, and navigation
- macOS-specific settings (titlebar, icons, etc.)
- Shell integration (fish shell)

### Adding New Themes

Theme files in `themes/` directory follow the format:

```
background = #1A1D23
foreground = #ADB0BB
palette = 0=#111317  # black
palette = 1=#FF838B  # red
# ... (16 color palette)
```

### Custom Shaders

GLSL shader files in `shaders/` directory implement visual effects. They use:

- `mainImage()` function as entry point
- `iResolution`, `iTime`, `iChannel0` uniforms
- `texture()` for terminal content sampling

## Common Tasks

To apply configuration changes, use the reload keybind: `cmd+r` or restart Ghostty.

To switch themes, modify the `theme` line in the config file and reload.
