#/!/bin/sh
name="en_dump_raw"
contexte="en_contexte"
nb=1
path="/home/xingyuchen/Desktop/PPE_website/PPE_website_marche_dans_la_lune/contextes/en_contexte"
while [ $nb -lt 81 ];
do
    if [ -f $name$nb ]
	then
        grep -i -w -A2 -B2 logic $name$nb > $path/$contexte$nb.txt
    else
		echo -e $raw"\terror" > $path/$contexte$nb.txt
    fi
    nb=$(expr $nb + 1)
done < $name$nb
