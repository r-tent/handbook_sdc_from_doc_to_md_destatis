cd ./Images/media
for file in *.wmf; do libreoffice --headless --convert-to png $file.wmf; done