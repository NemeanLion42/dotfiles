from libqtile import bar, layout, widget, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
import os, subprocess

mod = "mod4"
terminal = "alacritty"
web_browser = "google-chrome-stable"
file_manager = "nemo"
home = os.path.expanduser('~')

light_purple = "#b000ff"
lightish_purple = "a800d0"
darkish_purple = "#600080"
dark_purple = "#480060"

keys = [
    # Switch between windows
    Key([mod], "Left", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "Right", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "Down", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "Up", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),

    # Move windows between columns (or into new column) or within column
    Key([mod, "shift"], "Left", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "Right", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "Down", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "Up", lazy.layout.shuffle_up(), desc="Move window up"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),

    # Grow windows (shrink if at and moving toward edge of screen)
    Key([mod, "control"], "Left", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "Right", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "Down", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "Up", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),

    # Launch applications
    Key([mod], "t", lazy.spawn(terminal), desc="Launch " + terminal),
    Key([mod], "r", lazy.spawn("rofi -show drun"), desc="Start rofi"),
    Key([mod], "v", lazy.spawn("pavucontrol"), desc="Launch PulseAudio Volume Control"),
    Key([mod], "b", lazy.spawn("qutebrowser"), desc="Launch qutebrowser"),
    Key([mod], "w", lazy.spawn(web_browser), desc="Launch " + web_browser),
    Key([mod], "c", lazy.spawn("code"), desc="Launch Visual Studio Code"),
    Key([mod], "f", lazy.spawn(file_manager), desc="Launch " + file_manager),
    Key([mod], "s", lazy.spawn("steam"), desc="Launch Steam"),
    Key([mod], "d", lazy.spawn("gnome-disks"), desc="Launch Gnome Disks"),
    Key([mod], "e", lazy.spawn("emacsclient -c -a 'emacs'"), desc="Launch Emacs"),

    # Toggle between layouts
    Key([mod], "space", lazy.next_layout(), desc="Activate next layout"),

    # Control windows
    Key([mod, "control"], "x", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "control"], "m", lazy.window.toggle_maximize(), desc="Toggle maximize"),
    Key([mod, "control"], "n", lazy.window.toggle_minimize(), desc="Toggle minimize"),
    Key([mod, "control"], "f", lazy.window.toggle_fullscreen(), desc="Toggle fullscreen"),

    # Control qtile
    Key([mod, "control"], "r", lazy.restart(), desc="Restart qtile"),
    Key([mod, "control"], "z", lazy.spawn(home + "/.config/rofi/scripts/qtile-logout-options"), desc="Logout options"),

    # Brightness controls
    Key([mod], "period", lazy.spawn(home + "/.config/qtile/increase_brightness.sh"), desc="Increase brightness"),
    Key([mod], "comma", lazy.spawn(home + "/.config/qtile/decrease_brightness.sh"), desc="Decrease brightness"),

    # Alt-Tab
    Key(["mod1"], "Tab", lazy.spawn(home + "/.config/rofi/scripts/alt-tab"), desc="Change windows"),

    # Screenshots
    Key([mod, "mod1"], "f", lazy.spawn("flameshot full"), desc="Screenshot the entire desktop"),
    Key([mod, "mod1"], "s", lazy.spawn("flameshot screen"), desc="Screenshot the screen containing the mouse"),
    Key([mod, "mod1"], "a", lazy.spawn("flameshot gui"), desc="Screenshot an area"),
]

groups = [Group(i) for i in ["WWW", "SCHL", "GAME", "DEV", "COMM"]]

for i, group in enumerate(groups, 1):
    keys.extend([
        Key([mod], str(i), lazy.group[group.name].toscreen(),
            desc="Switch to group {}".format(group),
        ),
        Key([mod, "shift"], str(i), lazy.window.togroup(group.name, switch_group=True),
            desc="Switch to & move focused window to group {}".format(group),
        ),
        Key([mod, "control"], str(i), lazy.window.togroup(group.name, switch_group=False),
            desc="Move focused window to group {} without switching".format(group),
        ),
    ])

layouts = [
    layout.Columns(border_focus=light_purple,
                   border_normal=dark_purple,
                   border_width=4,
                   margin=4,
                   margin_on_single=0),
    layout.Max(),
]

widget_defaults = dict(
    font="Droid Sans Mono for Powerline",
    fontsize=20,
    padding=3,
    background="#000000ff",
)
extension_defaults = widget_defaults.copy()

def make_bar(main):
    return bar.Bar(
            [
                widget.CurrentLayoutIcon(),
                widget.GroupBox(
                    highlight_method="block",
                    this_current_screen_border=lightish_purple,
                    this_screen_border=lightish_purple,
                    other_current_screen_border=darkish_purple,
                    other_screen_border=darkish_purple,
                    spacing=4,
                    margin=3,
                    rounded=True,
                ),
                widget.TaskList(
                    highlight_method="block",
                    spacing=6,
                    margin=0,
                    border=lightish_purple,
                    unfocused_border=dark_purple,
                    rounded=True,
                    icon_size=20,
                ),
                widget.Spacer(length=396 if main else 0,
                              background="#00000000"),
                widget.Clock(format="%a %b %d %Y %I:%M:%S %p",
                             padding=10),
            ],
            size=30,
            background="#00000000",
        )

screens = [
    Screen(top=make_bar(True)),
    Screen(top=make_bar(False)),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Click([mod], "Button2", lazy.window.toggle_floating()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = False
bring_front_click = True
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
        Match(wm_class="jetbrains-studio"), # Android Studio
        Match(wm_class="nvidia-settings"), # Nvidia Settings
        Match(title="Origin"), # Origin
        Match(wm_class="Unity"), # Unity
        Match(title="zoom "), # Zoom notifications
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = False

wmname = "Qtile"

@hook.subscribe.startup
def autostart():
    subprocess.run(home + "/.config/qtile/autostart.sh")
