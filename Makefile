RED=\033[0;31m
NC=\033[0m

all:
	# update apt & apt-get
	echo "${RED} update apt & apt-get ${NC}"
	sudo apt-get update
	sudo apt update

	# git config
	echo "${RED} git config ${NC}"
	git config --global user.email "lucet.anatole@gmail.com"
	git config --global user.name "AnatoleLucet"

	# install curl
	echo "${RED} install curl ${NC}"
	sudo apt-get install curl

	# install i3wm
	echo "${RED} install i3wm ${NC}"
	sudo apt-get install i3

	# install vscode
	echo "${RED} install vscode ${NC}"
	wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
	sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
	sudo apt update
	sudo apt install code

	# install zsh & ho my zsh
	echo "${RED} install zsh & ho my zsh ${NC}"
	sudo apt-get install zsh
	chsh -s $$(which zsh)
	sh -c "$$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

	# install google chrome
	echo "${RED} install google chrome ${NC}"
	sudo sh -c 'echo "deb [arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list'
	wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
	sudo apt-get update
	sudo apt-get install google-chrome-stable

	# install pulseaudio
	echo "${RED} install pulseaudio ${NC}"
	sudo apt update
	sudo apt install pulseaudio
	sudo apt install pavucontrol

	# install docker
	echo "${RED} install docker ${NC}"
	sudo apt update
	sudo apt install apt-transport-https ca-certificates curl software-properties-common
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
	sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
	sudo apt update
	sudo apt install docker-ce
	sudo usermod -aG docker $(USER)

	# install docker-compose
	echo "${RED} install docker-compose ${NC}"
	sudo curl -L "https://github.com/docker/compose/releases/download/1.23.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
	sudo chmod +x /usr/local/bin/docker-compose

	# generate ssh key
	echo "${RED} generate ssh key ${NC}"
	ssh-keygen

	# install node & npm
	echo "${RED} install node & npm ${NC}"
	sudo apt-get update
	sudo apt-get install nodejs npm

ssh:
	echo "${RED} ssh ${NC}"
	cat ~/.ssh/id_rsa.pub

config/all:
	echo "${RED} config ${NC}"
	cp -f i3/config ~/.config/i3/config
	make config/code/import


config/code/export:
	echo "${RED} Exporting the vscode config ${NC}"
	code --list-extensions | xargs -L 1 echo code --install-extension > code/list-extensions.sh
	cp -rt  code/ ~/.config/Code/User/settings.json ~/.config/Code/User/keybindings.json ~/.config/Code/User/snippets

config/code/import:
	echo "${RED} Importing the vscode config ${NC}"
	sh code/list-extensions.sh
	cp -rt ~/.config/Code/User/ code/settings.json code/keybindings.json code/snippets

config/i3/export:
	echo "${RED} Exporting the i3 config ${NC}"
	cp -f ~/.config/i3/config i3/config

config/i3/import:
	echo "${RED} Importing the i3 config ${NC}"
	cp -f i3/config ~/.config/i3/config
