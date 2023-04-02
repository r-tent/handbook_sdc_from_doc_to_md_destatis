cd ./Images/media
for fil in *.wmf; do libreoffice --headless --convert-to png $fil.wmf; done