NUMIMAGE=1
FILEQ=./Images/tex/image$NUMIMAGE.tex
EQ=$(cat $FILEQ)
IM=Images\/media\/image$NUMIMAGE\.png
IMCHAR="\!\[\](Images\/media\/image$NUMIMAGE\.png)"

sed -i "s/$IMCHAR/$EQ/" test.qmd