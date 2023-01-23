It seems that there is no way to directly move from doc to md, so before starting export the .doc to .docx.

Then, the command line to export docx file to md is the following one:

`pandoc --extract-media=Images --wrap=none -f docx -t markdown .\Handbook_V1_2_2010_2.docx -o Handbook.md`

The most of equations were converted in .wmf files which are not readable for markdown. So, we have to convert them into .png files with the 
bash command line written in `bash_convert_images.sh`.

We can, then, create a quarto book inside the directory with vscode or R. It will automotically creates the necessary files for it.

Then, we split the single .md file to multiple .qmd (quarto) files with the R script written in `from_md_to_quarto_book.R` file.
This script splits the .md file at each h1 level (chapters) but this behavior could be changed (for example h2 level) to deal with smaller files. 
The script replaces the .wmf files by the .png files.


It remains at least to:

- convert images of equation to real latex equations;
- to remove old comments and maybe strore them elsewhere (Suprisingly, they are visible in the document (but not in the .doc, for me at least))
- check the page layout;

