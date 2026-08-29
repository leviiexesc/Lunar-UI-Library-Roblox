#!/usr/bin/env python3
from pathlib import Path
import sys

root = Path(__file__).resolve().parents[2]

required_paths = [
    root / "README.md",
    root / "LICENSE",
    root / "src",
    root / "examples",
]
missing = [str(path.relative_to(root)) for path in required_paths if not path.exists()]
if missing:
    raise SystemExit(f"Missing required paths: {', '.join(missing)}")

expected_files = [
    "src/LunarUI.lua",
    "src/Config.lua",
    "src/Section.lua",
    "src/Tab.lua",
    "src/Theme.lua",
    "src/Window.lua",
]
missing_files = [path for path in expected_files if not (root / path).exists()]
if missing_files:
    raise SystemExit(f"Missing expected project files: {', '.join(missing_files)}")

lua_files = sorted((root / "src").rglob("*.lua")) + sorted((root / "examples").rglob("*.lua"))
if not lua_files:
    raise SystemExit("No Lua files were found in src/ or examples/.")

for lua_file in lua_files:
    text = lua_file.read_text(encoding="utf-8")
    if not text.strip():
        raise SystemExit(f"Empty Lua file detected: {lua_file.relative_to(root)}")

print(f"Validated {len(lua_files)} Lua files successfully.")
print(f"Repository root: {root}")
