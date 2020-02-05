#!/bin/bash

##########SCRIPT DE PÓS INSTALAÇÃO DO LINUX MINT 19.03#########
#Escrito por Tiago G. Manoel
#Release - 2.5
#Data - 05/02/2020



#---VARIÁVEIS---#
INSYNC=https://d2t3ff60b2tol4.cloudfront.net/builds/insync_3.0.27.40677-bionic_amd64.deb
GOOGLE_CHROME=https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
ESCOLHA=Softwares

######Função Menu Principal######
declare -f MENU
function MENU()
{
	clear
	echo "=== MINT-AFTER-INSTALL-2.5 ==="
	PS3="Escolha uma opção! "
	select i in "Atualizar Repositórios e Sistema" "Instalar Softwares" sair
	do
	   case "$i" in
	      "Atualizar Repositórios e Sistema" )
	        ATUALIZAR
		 	;;
	      "Instalar Softwares" )
	        INSTMENU
	        ;;
	      sair )
	         echo "Encerrando..."
	         break
	         ;;
	      * )
	         echo "opcao inválida, tente novamente!"
	         ;;
	   esac
	done
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

######Funções de Instalação######
declare -f INSTMENU
function INSTMENU()
{
	selection=$(zenity --list --title='Selecione' --column="#" --column="Softwares" --column="Descrição" \
	FALSE "Google-Chrome-Stable" "Navegador Web" \
	FALSE "Insync" "Client Google Drive" \
	FALSE "Spotify-FlatHub" "Music Streaming" \
	FALSE "Telegram-FlatHub" "Messenger" \
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
	--separator=" "	--checklist  --height=650 --width=550 )
	
	if [[ -z $selection  ]]; then
		MENU
	fi

	echo "$selection"
	INSTPROGRAMA
}

declare -f INSTCHROME
function INSTCHROME()
{
	clear
	echo "#========== Instalando Google Chrome ==========#"
	sleep 2
	mkdir /tmp/chrome
	cd /tmp/chrome
	wget $GOOGLE_CHROME
	sudo dpkg -i *.deb
	echo "#========== Finalizado com sucesso! ==========#"
	sleep 3
    clear			
}

declare -f INSTINSYNC
function INSTINSYNC()
{
	clear
	echo "#========== Instalando Insync ==========#"
	sleep 2
	mkdir /tmp/insync
	cd /tmp/insync
	wget $INSYNC
	sudo dpkg -i *.deb
	echo "#========== Finalizado com sucesso! ==========#"
	sleep 3
    clear			
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
		case $ESCOLHA in
			Google-Chrome-Stable )
				echo "#========== Instalando $ESCOLHA ==========#"
				sleep 2
				INSTCHROME
				;;
			Insync )
				echo "#========== Instalando $ESCOLHA ==========#"
				sleep 2
				INSTINSYNC
				;;
			Spotify-FlatHub )
				echo "#========== Instalando $ESCOLHA ==========#"
				sleep 2
				flatpak install flathub com.spotify.Client -y
				;;
			Sublime-Text-FlatHub )
				echo "#========== Instalando $ESCOLHA ==========#"
				sleep 2
				flatpak install flathub com.sublimetext.three -y
				;;
			Handbrake-FlatHub )
				echo "#========== Instalando $ESCOLHA ==========#"
				sleep 2
				flatpak install flathub fr.handbrake.ghb -y 
				;;
			WPS-Office-FlatHub )
				echo "#========== Instalando $ESCOLHA ==========#"
				sleep 2
				flatpak install flathub com.wps.Office -y
				;;
			ONLYOFFICE-FlatHub )
				echo "#========== Instalando $ESCOLHA ==========#"
				sleep 2
				flatpak install flathub org.onlyoffice.desktopeditors -y
				;;	
			libreoffice )
				echo "#========== Instalando $ESCOLHA ==========#"
				sleep 2
				INSTLIBREOFFICE ;;
			Telegram-FlatHub )
				echo "#========== Instalando $ESCOLHA ==========#"
				sleep 2
				flatpak install flathub org.telegram.desktop -y
				 ;;	
			Descompactadores )
				echo "#========== Instalando $ESCOLHA ==========#"
				sleep 2
				sudo apt install p7zip-full p7zip-rar lzma lzma-dev rar unrar-free p7zip ark ncompress -y 
				;;	
			* )
				echo "#========== Instalando $ESCOLHA ==========#"
				sleep 2
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
