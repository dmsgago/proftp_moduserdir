#!/bin/bash

# Funciones
num_argumentos()
{
    if [[ $1 -ne "1" ]]
    then
	echo "Numero de argumentos inválido: $1"
	exit
    fi
}

# Programa principal

num_argumentos $#
useradd $1 -m -s /bin/bash -p $(mkpasswd usuario)
sed -i 's%</VirtualHost>%        Alias \"/'"$1"'\" \"/home/'"$1"'/ftp/\"\n        <Directory /home/'"$1"'/ftp>\n                Options Indexes FollowSymLinks\n       AllowOverride None\n                Require all granted\n        </Directory>\n</VirtualHost>%g' /etc/apache2/sites-available/iesgn.conf
systemctl restart apache2
