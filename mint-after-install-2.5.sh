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
	selection=$(zenity --list --checklist --width=300 --height=600  \
	--title='Selecione' --column="#" --column=Softwares \
	FALSE "Google-Chrome-Stable" \
	FALSE "Insync" \
	FALSE "Spotify-FlatHub" \
	FALSE "Sublime-Text-FlatHub" \
	FALSE "ubuntu-restricted-extras" \
	FALSE "mpv" \
	FALSE "celluloid" \
	FALSE "audacious" \
	FALSE "gnome-calendar" \
	FALSE "gnome-maps" \
	FALSE "gnome-contacts" \
	FALSE "shutter" \
	FALSE "flameshot" \
	FALSE "snapd" \
	FALSE "kdenlive" \
	FALSE "ffmpeg" \
	FALSE "mint-meta-codecs" \
	FALSE "winff" \
	FALSE "synaptic" \
	FALSE "gparted" \
	FALSE "geary" \
	FALSE "steam-installer" )

	if [[ -z $selection  ]]; then
		MENU
	fi

	echo "${selection//|/ }"
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

declare -f INSTPROGRAMA
function INSTPROGRAMA()
{
	clear
	echo "#========== Instalando $ESCOLHA ==========#"
	sleep 2
	clear
	for ESCOLHA in ${selection//|/ }; do
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