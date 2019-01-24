cat "iplist" | while read line
do
   echo "Test $line En Cours .."
   torify sshpass rsync --list-only  $line:: > testtmp.txt
   grep -Eo '^[^ ]+' testtmp.txt > testtmp2.txt
   sed 's/^/'$line',/' testtmp2.txt >> share.txt
   rm testtmp*
done


cat "share.txt" | while IFS=, read col1 col2
do
echo $col1/$col2 >> resultats.txt
torify sshpass rsync --list-only  $col1::$col2/ >> resultats.txt

done
rm share.txt
cat resultats.txt
