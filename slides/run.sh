#!/bin/sh
#pandoc -t beamer slides.md --slide-level=2 -o slides.pdf -V theme:metropolis --toc --toc-depth 1 "$@"
pandoc -t revealjs -s --dpi 120 slides.md --css=style.css --slide-level=2 -o slides.html -V theme=white -V height=800 "$@" 
echo "Syncing $PWD"
rsync -Paz "$PWD/" -e 'ssh -p 2222' root@slides.todevnull.com:/data/html/ 
echo 'Done'
