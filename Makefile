comment:=$(shell date)

deploy:
	bundle exec jekyll build; cd _site; \
	git add .; git commit -am '$(comment)'; \
	git push origin master; cd ../

publish:
	cp _drafts/* _posts/; \
	deploy

run:
	bundle exec jekyll serve
