#!/bin/bash

#Se lo script viene invocato senza una data di confronto, restituirà un messaggio di errore e l'exit code 1
if [ -z $1 ]
then
	echo 'Parametri mancanti, invocare lo script nel seguente modo: ' >&2
	echo "$0 <data_di_confronto>" >&2
	echo 'Il formato della data deve essere YYYY-MM-DD-HH:mm' >&2
	exit 1
fi

#Salvataggio dell'elenco dei file presenti nella directory corrente all'interno della variabile "nomiFile"
nomiFile=`ls`
nFile=0


echo
echo 'Elenco file modificati'
echo
#Ciclo necessario alla visuliazzazione dei file modificati dopo la data di confronto
for i in $nomiFile
do
	dataFile=`stat -c %y $i`
	#La data di modifica fornita dal comando "stat" viene scritta in un formato diverso in modo da essere confrontata con la data inserita dall'utente
	dataFile="${dataFile:0:10}-${dataFile:11:5}"
	if [[ $dataFile > $1 ]]
	then
		#Incremento del contatore che indica il numero di file modificati dopo la data immessa dall'utente
		nFile=$((nFile+1))
		#Visualizzazione in output dei file modificati dopo la data immessa dall'utente
		echo "File n.$nFile: $i"
	fi
done
