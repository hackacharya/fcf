#!/bin/bash

OUTFILE=fcf/contents.yaml

count=0
echo "contents:" > $OUTFILE
for archive in `find fcf -name *.zip | sort`
do
   CAT=`echo $archive | cut -d"/" -f2`
   SUBCAT=`echo $archive | cut -d"/" -f3`
   echo "  - archive: $archive" >> $OUTFILE
   echo "    category: $CAT" >> $OUTFILE
   echo "    subcategory: $SUBCAT" >> $OUTFILE
   echo "    files: " >> $OUTFILE
   for file in `zipinfo -1 $archive | sort`
   do 
   echo "      - $file " >> $OUTFILE
   done
   count=$((count+1))
   echo -e "\r\033[K$count.\t${archive} ... \c"
done
echo -e "\r\033[KProcessed $count files. $OUTFILE updated.\n"
