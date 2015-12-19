#!/bin/sh
bundle exec jekyll build;
cd _site;
git add .;
git commit -am 'Commits on $(date)';
git push origin master;
cd ..
