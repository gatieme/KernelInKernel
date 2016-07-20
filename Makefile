

COMMIT="增加了makefile, 完善了README.md..."



all:github


.PNONY	:	github
github	:
	git add -A
	git commit -m $(COMMIT)
	git push origin master
