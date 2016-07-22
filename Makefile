COMMIT="增加了make run3和make run4直接运行..."

KERNEL_3_DIR=mykernel-3.9.4

KERNEL_4_DIR=mykernel-4.1.0


.PNONY	:	github	run3	run4

all	:	github

#	github

GITHUB_COMMIT=$(COMMIT)
github	:
	git add -A
	git commit -m $(GITHUB_COMMIT)
	git push origin master

#	run your kernel(KINK)
run3	:
	cd $(KERNEL_3_DIR) && make run

run4	:
	cd $(KERNEL_4_DIR) && make run
