oilup(){
	echo """
	+===================================+
	| Welcome to semisapeol (isg32)'s   |
	| Bspwm Auto-dot for Debian/Ubuntu  |
	+===================================+
	"""
}


getPacks(){
	sudo apt install bspwm sxhkd polybar compton rofi dunst nitrogen i3lock redshift cmus ranger
}

configup(){
	mkdir ~/.config/bspwm
	mkdir ~/.config/sxhkd
	mkdir ~/.config/polybar

	echo "Configuring bspwm..."
	cp /usr/share/doc/bspwm/examples/bspwmrc ~/.config/bspwm/
	chmod u+x ~/.config/bspwm/bspwmrc
	
	echo "Configuring sxhkd..."
	cp /usr/share/doc/bspwm/examples/sxhkdrc ~/.config/sxhkd/
	
	echo "Configuring polybar..."
	cp /etc/polybar/config.ini ~/.config/polybar/
	
	
	# Installing NerdFonts
	echo "Installing Nerd Fonts..."
	cd Downloads
	wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/JetBrainsMono.zip
	dtrx JetBrainsMono.zip
	sudo cp -avr JetBrainsMono/ /usr/share/fonts/truetype/
	fc-cache -f -v
	rm JetBrainsMono.zip
}

appendConfs(){
	preconf_sxhkd = """
	Super + d:                rofi
	Super + Return:           terminal
	Super + Shift + return:   floating terminal
	Super + {1–9}:            go to ws
	Super + Ctrl + {Left, Right}: go to ws
	Super + Shift + {1–9}:    move window to ws
	Super + f:                floating
	Super + w:                monocle
	Super + q:                close window
	Super + Shift + q:        quit wm
	Super + l:                session menu
	Super + Esc:              reload sxhkd
	Super + Alt + e:          reload bspwm
	"""
	echo "Tweaking sxhkd Config..."
	echo $preconf_sxhkd >> ~/.config/sxhkd/sxhkdrc
	

	preconf_bspwm = """

	sxhkd &
	compton --backend glx --vsync opengl-swc &
	usr/lib/xfce-polkit/xfce-polkit &
	~/bin/polybar.launch.sh &
	nitrogen --restore &
	"""
	echo "Tweaking bspwm Config..."
	echo $preconf_bspwm >> ~/.config/bspwm/bspwmrc


	preconf_polybar = """

	#!/usr/bin/env sh
	
	# Terminate already running bar instances
	killall -q polybar

	# Wait until the processes have been shut down
	while pgrep -x polybar >/dev/null; do sleep 1; done

	# Launch: 'top' is the name of my Polybar
	polybar &
	"""
	echo "Tweaking Polybar Config..."
	sudo echo $preconf_polybar >> ~/bin/polybar.launch.sh
	
	preconf_compton = """
	# shorter shadows
	shadow-radius = 5;
	shadow-offset-x = -5;
	shadow-offset-y = -5;
	shadow-opacity = 0.8;
	# faster animations
	fade-in-step = 0.07;
	fade-out-step = 0.07;
	"""
	echo "Tweaking Compton Config..."
	sudo echo $preconf_compton >> ~/.config/compton.conf
}

oilup
getPacks
configup
appendConfs
