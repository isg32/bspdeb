oilup(){
	echo """
	+===================================+
	| Welcome to semisapeol (isg32)'s   |
	| Bspwm Auto-dot for Debian/Ubuntu  |
	+===================================+
	"""
}

SetCurrentdir(){
	path=$pwd
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
	pip install dtrx
	echo "Installing Nerd Fonts..."
	cd ~/Downloads
	wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/JetBrainsMono.zip
	dtrx JetBrainsMono.zip
	sudo cp -avr JetBrainsMono/ /usr/share/fonts/truetype/
	fc-cache -f -v
	rm JetBrainsMono.zip
	cd ~/.
}

appendConfs(){
	cd $path
	echo "Tweaking sxhkd Config..."
	echo "$(cat tweaks_sxhkd)" >> ~/.config/sxhkd/sxhkdrc
	
	echo "Tweaking bspwm Config..."
	echo "$(cat tweaks_bspwm)" >> ~/.config/bspwm/bspwmrc

	echo "Tweaking Polybar Config..."
	touch ~/bin/polybar.launch.sh
	sudo echo "$(cat polybar.launch)" >> ~/bin/polybar.launch.sh

	echo "Tweaking Compton Config..."
	sudo echo "$(cat tweaks_compton)" >> ~/.config/compton.conf
}

oilup
getPacks
configup
appendConfs
