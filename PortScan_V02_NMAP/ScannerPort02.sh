#!/usr/bin/env bash

###########################################################################

    #Chame o Script com o bash e nome do script
    #Ex.: bash ScannerPort02.sh

    #pode ser colocado parametros também como: 
    #Ex.: bash Scannerport.sh 192.168.1.1 e o ultimo octeto do IP 255

###########################################################################


Diretorio="SEU DIRETORIO"
GeradorLogs="SEU DIRETORIO/log.txt"

if ! command -v awk &>/dev/null; then

            sudo apt-get install gawk
            echo "Nmap instalado." | awk '{print strftime("%d/%m/%Y %H:%M"), $0 }' >>"$GeradorLogs"
        else    
            echo "Nmap nao foi instalado, o programa ja existe." | awk '{print strftime("%d/%m/%Y %H:%M"), $0 }' >>"$GeradorLogs"
fi

if [ "$EUID" -ne 0 ];
then
    echo "Voce precisa ser Administrador Root" | awk '{print strftime("%d/%m/%Y %H:%M"), $0 }' >>"$GeradorLogs"
    exit 1

fi 

if [ ! -x "$0" ]; then
    chmod +x "$0"

    if [ $? -ne 0 ]; then
          echo "Erro ao tornar o script executavel" | awk ' {print strftime("%d/%m/%Y %H:%M"), $0 }' >> "$GeradorLogs"
          exit 1 
        else
            echo "Script executado com sucesso." | awk '{print strftime("%d/%m/%Y %H:%M"), $0 }' >> "$GeradorLogs"       
    fi
    
fi


if [[ ! -d $Diretorio ]];
    then 

        mkdir -p "$Diretorio" 
        mkdir -p "$(dirname "$GeradorLogs")"

        echo "Diretorio criado: $Diretorio" | awk ' {print strftime("%d/%m/%Y %H:%M"), $0 }' >> "$GeradorLogs"
    else
        echo "Diretorio Existente" "$Diretorio" | awk ' {print strftime("%d/%m/%Y %H:%M"), $0 }' >> "$GeradorLogs"    
    fi

    if ! command -v nmap &>/dev/null; then

            sudo apt install nmap
            echo "Nmap instalado." | awk '{print strftime("%d/%m/%Y %H:%M"), $0 }' >>"$GeradorLogs"
        else    
            echo "Nmap nao foi instalado, o programa ja existe." | awk '{print strftime("%d/%m/%Y %H:%M"), $0 }' >>"$GeradorLogs"
    
fi

 if [ $# -ne 2 ]; then
    
    exit 1
 fi  

BlocoDeIP="$1"
FimDeBloco="$2"

nmap -T4 -F -Pn "$BlocoDeIP" "$FimDeBloco" | tee -a "$GeradorLogs"
echo "$BlocoDeIP"
   

