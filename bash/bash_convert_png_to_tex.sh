cd ./Images/media
for fil in *.png; do mpx convert $fil ../tex/${fil%.*}.tex; done