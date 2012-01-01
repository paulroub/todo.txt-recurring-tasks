all:	recur

install:	recur
	cp recur ~/.todo.actions.d

recur:	todo-recur.pl $(wildcard lib/Todotxt/*.pm)
	pp -o recur -P --lib=lib todo-recur.pl

test:
	perl  "-MExtUtils::Command::MM" -e "test_harness(0,lib,t)" t/*.t
