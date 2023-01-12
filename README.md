It seems that there is no way to directly move from doc to md, so before starting export the .doc to .docx.

Then, the command line to export docx file to md is the following one:

`pandoc --extract-media=Images --wrap=none -f docx -t markdown .\Handbook_V1_2_2010_2.docx -o Handbook.md`

It remains some issues (size and label of figures for example) but it seems to work very well.