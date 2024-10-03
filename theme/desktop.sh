#!/bin/bash

# Paths
config="$HOME/.config"
nvim="$config/nvim"
rofi="$config/rofi"
zathura="$config/zathura/zathurarc"
xresources="$HOME/.Xresources"
kitty="$HOME/.config/kitty/kitty.conf"
xsettingsd="$HOME/.config/xsettingsd/xsettingsd.conf"
tilix_config="$HOME/.config/tilix/schemes/Theme.json"
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
		;;
	*)
		echo "Unknown theme: $1"
		exit 1
		;;
	esac
}

# Update terminal colors
term() {
	sed -i -e "s/*.foreground: .*/*.foreground: $FG/g" \
		-e "s/*.background: .*/*.background: [92]$BG/g" \
		-e "s/*.cursorColor: .*/*.cursorColor: [50]$G/g" \
		-e "s/*.color0: .*/*.color0: $BL/g" \
		-e "s/*.color8: .*/*.color8: $BL/g" \
		-e "s/*.color7: .*/*.color7: $WH/g" \
		-e "s/*.color15: .*/*.color15: $WH/g" \
		-e "s/*.color1: .*/*.color1: $R/g" \
		-e "s/*.color9: .*/*.color9: [60]$R/g" \
		-e "s/*.color2: .*/*.color2: [90]$G/g" \
		-e "s/*.color10: .*/*.color10: [70]$G/g" \
		-e "s/*.color3: .*/*.color3: $Y/g" \
		-e "s/*.color11: .*/*.color11: $Y/g" \
		-e "s/*.color4: .*/*.color4: $B/g" \
		-e "s/*.color12: .*/*.color12: $B/g" \
		-e "s/*.color5: .*/*.color5: $M/g" \
		-e "s/*.color13: .*/*.color13: [50]$M/g" \
		-e "s/*.color6: .*/*.color6: $C/g" \
		-e "s/*.color14: .*/*.color14: $C/g" $xresources

	xrdb $xresources
}

gtk() {
	sed -i -e "s/gtk-theme-name= .*/gtk-theme-name= $1/g" \
		-e "s/gtk-icon-theme-name= .*/gtk-icon-theme-name= $2/g" \
		-e "s/gtk-cursor-theme-name= .*/gtk-cursor-theme-name= $3/g" $gtk

	sed -i -e "s/Net\/ThemeName .*/Net\/ThemeName \"$1\"/g" \
		-e "s/Net\/IconThemeName .*/Net\/IconThemeName \"$2\"/g" \
		-e "s/Net\/CursorThemeName .*/Net\/CursorThemeName \"$3\"/g" $xsettingsd

	sed -i -e "s/Xcursor.theme: .*/Xcursor.theme: $3/g" $xresources

	killall xsettingsd
	xsettingsd &
}

rofi() {
	sed -i -e "s/bg: .*/bg: $BG;/g" \
		-e "s/se: .*/se: $Ya4;/g" \
		-e "s/fg: .*/fg: $FG;/g" \
		-e "s/br: .*/br: $Rf0;/g" $rofi/colors.rasi
}

nvim() {
	sed -i -e "s/^      colorscheme = .*/      colorscheme = \"$1\",/g" $nvim/lua/plugins/colorshemes.lua
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

tilix() {
	# Update Tilix theme via dconf
	# dconf write /com/gexperts/Tilix/profiles/list "['$profile']"
	# dconf write /com/gexperts/Tilix/profiles/current "$profile"

	dconf write /com/gexperts/Tilix/profiles/2b7c4080-0ddd-46c5-8f23-563fd3ba789d/background-color "'$BG'"
	dconf write /com/gexperts/Tilix/profiles/2b7c4080-0ddd-46c5-8f23-563fd3ba789d/foreground-color "'$FG'"
	dconf write /com/gexperts/Tilix/profiles/2b7c4080-0ddd-46c5-8f23-563fd3ba789d/palette "'$BL:$R:$G:$Y:$B:$M:$C:$WH:$BL:$R:$G:$Y:$B:$M:$C:$WH'"
}

if [ -z "$1" ]; then
	echo "Please provide a theme name (e.g., oxocarbon, gruvbox, nord)"
	exit 1
fi

theme=$1

set_theme $theme

# nvim $theme
zathura
rofi
gtk "oxocarbon" "oxocarbon" "Lighted-Pixel-Sky-vr1"
term
tilix
