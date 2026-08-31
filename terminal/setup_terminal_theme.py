#!/usr/bin/env python3
"""
Creates/updates two Terminal.app profiles, "Mono Light" and "Mono Dark":
JetBrainsMono Nerd Font Mono @ 15pt, with a full base + 16-color ANSI
palette (Gruvbox-darker for dark, a cool-neutral bold-accent palette for
light, both re-tuned to clear WCAG AA contrast).

Font/background/text/cursor are settable live via AppleScript and apply
immediately. The 16 ANSI colors are NOT exposed by Terminal's AppleScript
dictionary at all -- they're written directly into
~/Library/Preferences/com.apple.Terminal.plist using the same
NSKeyedArchiver-encoded NSColor format Terminal itself uses. Terminal only
loads this from disk at launch, so ANSI colors won't appear until you quit
and reopen Terminal.app (a plain relaunch, not a full logout).
"""
import plistlib
import subprocess
import sys

FONT_NAME = "JetBrainsMono Nerd Font Mono"
FONT_SIZE = 15

# 16-bit AppleScript color = round(byte * 257)
def rgb16(hexstr):
    hexstr = hexstr.lstrip("#")
    r, g, b = (int(hexstr[i : i + 2], 16) for i in (0, 2, 4))
    return r * 257, g * 257, b * 257


PROFILES = {
    "Mono Light": {
        "background": "F4F4F5",
        "text": "24272B",
        "bold_text": "101113",
        "cursor": "D65D0E",
        "ansi": {
            "ANSIBlackColor": "24272B",
            "ANSIRedColor": "CF222E",
            "ANSIGreenColor": "116329",
            "ANSIYellowColor": "8A5B00",
            "ANSIBlueColor": "0969DA",
            "ANSIMagentaColor": "8250DF",
            "ANSICyanColor": "007A8C",
            "ANSIWhiteColor": "4B5563",
            "ANSIBrightBlackColor": "5B6472",
            "ANSIBrightRedColor": "A0111C",
            "ANSIBrightGreenColor": "0B4D1E",
            "ANSIBrightYellowColor": "6B4400",
            "ANSIBrightBlueColor": "054FA8",
            "ANSIBrightMagentaColor": "6739B3",
            "ANSIBrightCyanColor": "045F6E",
            "ANSIBrightWhiteColor": "6B7280",
        },
    },
    "Mono Dark": {
        "background": "16181A",
        "text": "EBDBB2",
        "bold_text": "FBF1C7",
        "cursor": "FE8019",
        "ansi": {
            "ANSIBlackColor": "282828",
            "ANSIRedColor": "CC241D",
            "ANSIGreenColor": "98971A",
            "ANSIYellowColor": "D79921",
            "ANSIBlueColor": "458588",
            "ANSIMagentaColor": "B16286",
            "ANSICyanColor": "689D6A",
            "ANSIWhiteColor": "A89984",
            "ANSIBrightBlackColor": "928374",
            "ANSIBrightRedColor": "FB4934",
            "ANSIBrightGreenColor": "B8BB26",
            "ANSIBrightYellowColor": "FABD2F",
            "ANSIBrightBlueColor": "83A598",
            "ANSIBrightMagentaColor": "D3869B",
            "ANSIBrightCyanColor": "8EC07C",
            "ANSIBrightWhiteColor": "EBDBB2",
        },
    },
}


def run_applescript(script):
    subprocess.run(["osascript", "-e", script], check=True, capture_output=True)


def setup_profile_live(name, cfg):
    r, g, b = rgb16(cfg["background"])
    tr, tg, tb = rgb16(cfg["text"])
    br, bg_, bb = rgb16(cfg["bold_text"])
    cr, cg, cb = rgb16(cfg["cursor"])
    script = f"""
    tell application "Terminal"
        if not (exists settings set "{name}") then
            duplicate settings set "Basic" to end of settings sets with properties {{name:"{name}"}}
        end if
        set target to settings set "{name}"
        set font name of target to "{FONT_NAME}"
        set font size of target to {FONT_SIZE}
        set background color of target to {{{r}, {g}, {b}}}
        set normal text color of target to {{{tr}, {tg}, {tb}}}
        set bold text color of target to {{{br}, {bg_}, {bb}}}
        set cursor color of target to {{{cr}, {cg}, {cb}}}
    end tell
    """
    run_applescript(script)


def archive_color(r, g, b):
    rgb_str = f"{r:.10f} {g:.10f} {b:.10f} \x00".encode("ascii")
    d = {
        "$archiver": "NSKeyedArchiver",
        "$objects": [
            "$null",
            {"$class": plistlib.UID(2), "NSColorSpace": 1, "NSRGB": rgb_str},
            {"$classes": ["NSColor", "NSObject"], "$classname": "NSColor"},
        ],
        "$top": {"root": plistlib.UID(1)},
        "$version": 100000,
    }
    return plistlib.dumps(d, fmt=plistlib.FMT_BINARY)


def hex_to_frac(hexstr):
    hexstr = hexstr.lstrip("#")
    return tuple(int(hexstr[i : i + 2], 16) / 255.0 for i in (0, 2, 4))


def write_ansi_colors():
    prefs_path = f"{__import__('os').path.expanduser('~')}/Library/Preferences/com.apple.Terminal.plist"
    with open(prefs_path, "rb") as f:
        prefs = plistlib.load(f)

    for profile_name, cfg in PROFILES.items():
        entry = prefs["Window Settings"][profile_name]
        for key, hexval in cfg["ansi"].items():
            r, g, b = hex_to_frac(hexval)
            entry[key] = archive_color(r, g, b)

    with open(prefs_path, "wb") as f:
        plistlib.dump(prefs, f, fmt=plistlib.FMT_BINARY)


def main():
    for name, cfg in PROFILES.items():
        setup_profile_live(name, cfg)
        print(f"[terminal-theme] created/updated live colors for {name!r}")

    write_ansi_colors()
    print("[terminal-theme] wrote 16-color ANSI palette for both profiles")
    print()
    print("IMPORTANT: quit and reopen Terminal.app once (Cmd+Q, then relaunch)")
    print("for the ANSI accent colors to take effect -- Terminal only loads")
    print("them from disk at launch, and there's no live-reload API for them.")


if __name__ == "__main__":
    if sys.platform != "darwin":
        print("This script only applies to Terminal.app on macOS.", file=sys.stderr)
        sys.exit(1)
    main()
