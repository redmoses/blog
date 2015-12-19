#!/bin/sh
date_now=$(date)
bundle exec jekyll build;
cd _site;
git add .;
git commit -am "Commits on $date_now";
git push origin master;
cd ..
