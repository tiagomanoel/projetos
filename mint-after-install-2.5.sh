#!/bin/bash

##########SCRIPT DE PÓS INSTALAÇÃO DO LINUX MINT 19.03#########
#Escrito por Tiago G. Manoel
#Release - 2.5
#Data - 15/02/2020



#---VARIÁVEIS---#
INSYNC=https://d2t3ff60b2tol4.cloudfront.net/builds/insync_3.0.27.40677-bionic_amd64.deb
GOOGLE_CHROME=https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
ESCOLHA=Softwares

######Função Menu Principal######
declare -f MENU
function MENU()
{
	selection=$(zenity --list --title='Selecione' --column="#" --column="Softwares"  \
	FALSE "Atualizar Repositórios e Sistema" \
	FALSE "Instalar Softwares" \
	FALSE "Desinstalar Embarcados" \
	--radiolist  --height=200 --width=300 )
	
	if [[ -z $selection  ]]; then
		exit 0
	fi
	case "$selection" in
	   "Atualizar Repositórios e Sistema" )
	    	ATUALIZAR
			;;
	   	"Instalar Softwares" )
	    	INSTMENU
	    	;;
	   	"Desinstalar Embarcados" )
			RMMENU
			;;
	    * )
	        echo "opcao inválida, tente novamente!"
	        ;;
	esac
	exit 0
}

######Função de Atualização do Sistema######
declare -f ATUALIZAR
function ATUALIZAR()
{
	clear
	echo "=== Atualizando Repositórios ==="
	sleep 2
	sudo rm /var/lib/dpkg/lock-frontend
	sudo rm /var/cache/apt/archives/lock
	sudo apt update -y
	clear
	echo "=== Aplicadando Atulizações ==="
	sleep 2
	sudo apt dist-upgrade -y
	clear
	echo "=== Terminado ==="
	sleep 3
	MENU
}

######Funções de Instalação e Remoção######
declare -f INSTMENU
function INSTMENU()
{
	selection=$(zenity --list --title='Selecione' --column="#" --column="Softwares" --column="Descrição" \
	FALSE "Google-Chrome-Stable" "Navegador Web" \
	FALSE "Insync" "Client Google Drive" \
	FALSE "Spotify-FlatHub" "Music Streaming" \
	FALSE "Telegram-FlatHub" "Messenger" \
	FALSE "whatsapp-desktop" "Messenger" \
 	FALSE "Sublime-Text-FlatHub" "IDE para desenvolvimento" \
	FALSE "ubuntu-restricted-extras" "Adicionais (codec, flash e etc...)" \
	FALSE "mpv" "Player de Vídeo" \
	FALSE "celluloid" "Player de Vídeo" \
	FALSE "audacious" "Player de Áudio" \
	FALSE "gnome-calendar" "Calendário" \
	FALSE "gnome-maps" "Mapas" \
	FALSE "gnome-contacts" "Agenda de Contatos" \
	FALSE "shutter" "Ferramenta para PrintScreen" \
	FALSE "flameshot" "Ferramenta para PrintScreen" \
	FALSE "snapd" "Core para containers SNAP" \
	FALSE "kdenlive" "Editor de Vídeo" \
	FALSE "ffmpeg" "Ferramenta Back-End para conversão de media" \
	FALSE "winff" "Front-End para FFMPEG"\
	FALSE "mint-meta-codecs" "Pacote de Codecs" \
	FALSE "synaptic" "Gerenciador de pacotes" \
	FALSE "gparted" "Gerenciador de partições" \
	FALSE "geary" "Client E-Mail" \
	FALSE "clipit" "Gerenciador de Clipboard" \
	FALSE "virtualbox-qt" "Virtualização" \
	FALSE "wine-stable" "Camada para Softwares Windows" \
	FALSE "libreoffice" "Ferramentas de escritório" \
	FALSE "Handbrake-FlatHub" "Ferramentas para conversão de Vídeo" \
	FALSE "WPS-Office-FlatHub" "Ferramentas de escritório" \
	FALSE "ONLYOFFICE-FlatHub" "Ferramentas de escritório" \
	FALSE "transmission" "Client torrent" \
	FALSE "keepassxc" "Gerenciador de senhas" \
	FALSE "Descompactadores" "p7zip-full p7zip-rar lzma lzma-dev rar unrar-free p7zip ark ncompress" \
	FALSE "steam-installer" "Game Store" \
	FALSE "zsnes" "Emulador de SuperNes" \
	FALSE "ttf-mscorefonts-installer" "Fontes Microsoft" \
	--separator=" "	--checklist  --height=650 --width=550 )
	
	if [[ -z $selection  ]]; then
		MENU
	fi

	INSTPROGRAMA
}

declare -f RMMENU
function RMMENU()
{
	selection=$(zenity --list --title='Selecione' --column="#" --column="Softwares" --column="Descrição" \
	FALSE "hexchat" "Chat" \
	FALSE "firefox" "Navegador Web" \
	FALSE "thunderbird" "Client E-Mail" \
	FALSE "rhythmbox" "Player de Musíca" \
	--separator=" "	--checklist  --height=650 --width=550 )
	
	if [[ -z $selection  ]]; then
		MENU
	fi

	RMPROGRAMAS
}

declare -f RMPROGRAMAS
 function RMPROGRAMAS()
 {
 	for ESCOLHA in $selection; do
 		echo "#========== Removendo $ESCOLHA ==========#"
		sleep 2
 		sudo apt remove $ESCOLHA -y
 	done
 	MENU
 }

declare -f INSTCHROME
function INSTCHROME()
{
	mkdir /tmp/chrome
	cd /tmp/chrome
	wget $GOOGLE_CHROME
	sudo dpkg -i *.deb
}

declare -f INSTINSYNC
function INSTINSYNC()
{
	mkdir /tmp/insync
	cd /tmp/insync
	wget $INSYNC
	sudo dpkg -i *.deb
}

declare -f INSTLIBREOFFICE
function INSTLIBREOFFICE()
{
	sudo add-apt-repository ppa:libreoffice/ppa -y
	sudo apt update && sudo apt dist-upgrade -y
	which libreoffice || sudo apt install libreoffice libreoffice-l10n-br -y
}

declare -f INSTPROGRAMA
function INSTPROGRAMA()
{
	clear
	echo "#========== Instalando $ESCOLHA ==========#"
	sleep 2
	clear
	for ESCOLHA in $selection; do
		echo "#========== Instalando $ESCOLHA ==========#"
		sleep 2
		case $ESCOLHA in
			Google-Chrome-Stable )
				INSTCHROME
				;;
			Insync )
				INSTINSYNC
				;;
			Spotify-FlatHub )
				flatpak install flathub com.spotify.Client -y
				;;
			Sublime-Text-FlatHub )
				flatpak install flathub com.sublimetext.three -y
				;;
			Handbrake-FlatHub )
				flatpak install flathub fr.handbrake.ghb -y 
				;;
			WPS-Office-FlatHub )
				flatpak install flathub com.wps.Office -y
				;;
			ONLYOFFICE-FlatHub )
				flatpak install flathub org.onlyoffice.desktopeditors -y
				;;	
			libreoffice )
				INSTLIBREOFFICE ;;
			Telegram-FlatHub )
				flatpak install flathub org.telegram.desktop -y
				 ;;	
			Descompactadores )
				sudo apt install p7zip-full p7zip-rar lzma lzma-dev rar unrar-free p7zip ark ncompress -y 
				;;	
			* )
				apt install $ESCOLHA -y 
				;;	
		esac		
	done 
	echo "#========== Finalizado com sucesso! ==========#"
	sleep 3
    clear
    MENU			
}

#==========EXECUÇÂO==========#
MENU
