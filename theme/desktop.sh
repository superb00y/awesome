#!/bin/bash

# Paths
config="$HOME/.config"
zathura="$config/zathura/zathurarc"
xresources="$HOME/.Xresources"
xsettingsd="$HOME/.config/xsettingsd/xsettingsd.conf"
gtk="$HOME/.config/gtk-3.0/settings.ini"

# Define themes
set_theme() {
	case $1 in
	"oxocarbon")
		BG="#161616"
		FG="#dde1e6"
		BL="#393939"
		WH="#464646"
		R="#ee5396"
		G="#ff7eb6"
		Y="#78a9ff"
		B="#42be65"
		M="#08bdba"
		C="#3ddbd9"
		GTK="tokyonight"
		ICONS="tokyonight"
		COURSOR="tokyonight"
		;;
	"gruvbox")
		BG="#282828"
		FG="#ebdbb2"
		BL="#928374"
		WH="#f2e5bc"
		R="#fb4934"
		G="#b8bb26"
		Y="#fabd2f"
		B="#83a598"
		M="#d3869b"
		C="#8ec07c"
		GTK="tokyonight"
		ICONS="tokyonight"
		COURSOR="tokyonight"
		;;
	"nord")
		BG="#2e3440"
		FG="#d8dee9"
		BL="#3b4252"
		WH="#eceff4"
		R="#bf616a"
		G="#a3be8c"
		Y="#ebcb8b"
		B="#81a1c1"
		M="#b48ead"
		C="#88c0d0"
		GTK="tokyonight"
		ICONS="tokyonight"
		COURSOR="tokyonight"
		;;
	"tokyonight")
		BG="#1a1b26"
		FG="#a9b1d6"
		BL="#414868"
		WH="#c0caf5"
		R="#f7768e"
		G="#73daca"
		Y="#e0af68"
		B="#7aa2f7"
		M="#bb9af7"
		C="#7dcfff"
		GTK="tokyonight"
		ICONS="tokyonight"
		COURSOR="tokyonight"
		;;
	"adwaita")
		BG="#282828"
		FG="#eeeeee"
		BL="#1e1e1e"
		WH="#eeeeee"
		R="#ed333b"
		G="#57e389"
		Y="#ffa348"
		B="#1c71d8"
		M="#e05c91"
		C="#5bc8af"
		GTK="adwaita"
		ICONS="oomox-adwaita"
		COURSOR="adwaita"
		;;
	"catppuccin")
		BG="#1e1e2e"
		FG="#cdd6f4"
		BL="#6c7086"
		WH="#f5e0dc"
		R="#f38ba8"
		G="#a6e3a1"
		Y="#f9e2af"
		B="#89b4fa"
		M="#d6bffd"
		C="#94e2d5"
		GTK="catppuccin"
		ICONS="catppucin"
		COURSOR="catppucin"
		;;
	"biscuit")
		BG="#221e1e"
		FG="#f4e6d2"
		BL="#423939"
		WH="#f4e6d2"
		R="#ca3f3f"
		G="#989f56"
		Y="#e39c45"
		B="#4a5a8d"
		M="#c45497"
		C="#629386"
		GTK="biscuit"
		ICONS="biscuit"
		COURSOR="biscuit"
		;;
	"nigthowl")
		BG="#011627"
		FG="#d6deeb"
		BL="#011627"
		WH="#d6deeb"
		R="#dc6563"
		G="#e7947c"
		Y="#ffeb95"
		B="#82aaff"
		M="#c792ea"
		C="#7fdbca"
		GTK="Awesthetic-dark"
		ICONS="adwaita"
		COURSOR="Chroma-Black-S"
		;;
	"ayu_dark")
		BG="#0d1017"
		FG="#bfbdb6"
		BL="#0d1017"
		WH="#bfbdb6"
		R="#f07178"
		G="#7fd962"
		Y="#e6b673"
		B="#39bae6"
		M="#dea6ff"
		C="#95e6cb"
		GTK="Awesthetic-dark"
		ICONS="adwaita"
		COURSOR="Chroma-Black-S"
		;;
	"amarena")
		BG="#1a2026"
		FG="#ffffff"
		BL="#12161a"
		WH="#ffffff"
		R="#bf616a"
		G="#a3be8c"
		Y="#ebcb8b"
		B="#5e81ac"
		M="#b48ead"
		C="#88c0d0"
		GTK="tokyonight"
		ICONS="tokyonight"
		COURSOR="tokyonight"
		;;
	"everbluesh")
		BG="#1c1f24"
		FG="#ffffff"
		BL="#5e6773"
		WH="#c5cdd9"
		R="#ff5f56"
		G="#5fd88d"
		Y="#fabd2f"
		B="#7aa2f7"
		M="#d687ff"
		C="#5fd7ff"
		GTK="tokyonight"
		ICONS="tokyonight"
		COURSOR="tokyonight"
		;;
	*)
		echo "Unknown theme: $1"
		exit 1
		;;
	esac
}

gtk() {
	sed -i -e "s/gtk-theme-name= .*/gtk-theme-name=$GTK/g" \
		-e "s/gtk-icon-theme-name= .*/gtk-icon-theme-name=$ICONS/g" \
		-e "s/gtk-cursor-theme-name= .*/gtk-cursor-theme-name=$COURSOR/g" $gtk

	sed -i -e "s/Net\/ThemeName .*/Net\/ThemeName \"$GTK\"/g" \
		-e "s/Net\/IconThemeName .*/Net\/IconThemeName \"$ICONS\"/g" \
		-e "s/Net\/CursorThemeName .*/Net\/CursorThemeName \"$COURSOR\"/g" $xsettingsd

	sed -i -e "s/Xcursor.theme: .*/Xcursor.theme: $COURSOR/g" $xresources

	killall xsettingsd
	xsettingsd &
}

zathura() {
	sed -i -e "s/set default-bg .*/set default-bg 'rgba(10,10,13,0.8)'/g" \
		-e "s/set default-fg .*/set default-fg '$FG'/g" \
		-e "s/set recolor-darkcolor .*/set recolor-darkcolor '$FG'/g" \
		-e "s/set recolor-lightcolor .*/set recolor-lightcolor '$BG'/g" \
		-e "s/set highlight-color .*/set highlight-color 'rgba(100,10,133,0.4)'/g" \
		-e "s/set highlight-active-color .*/set highlight-active-color 'rgba(10,10,13,0.8)'/g" \
		-e "s/set tabbar-bg .*/set tabbar-bg '$BG'/g" \
		-e "s/set tabbar-fg .*/set tabbar-fg '$FG'/g" \
		-e "s/set statusbar-bg .*/set statusbar-bg '$BG'/g" \
		-e "s/set statusbar-fg .*/set statusbar-fg '$FG'/g" \
		-e "s/set inputbar-bg .*/set inputbar-bg '$BG'/g" \
		-e "s/set inputbar-fg .*/set inputbar-fg '$R'/g" $zathura
}

if [ -z "$1" ]; then
	echo "Please provide a theme name (e.g., oxocarbon, gruvbox, nord)"
	exit 1
fi

theme=$1
set_theme $theme
zathura
gtk "oxocarbon" "oxocarbon" "Lighted-Pixel-Sky-vr1"
