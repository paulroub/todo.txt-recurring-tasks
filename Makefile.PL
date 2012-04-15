use ExtUtils::MakeMaker;

WriteMakefile(
	NAME	=> 'Todotxt::Recur',
	ABSTRACT => 'Recurring-tasks maintenance for todo.txt',
	AUTHOR => 'Paul Roub <paul@roub.net>',
	VERSION_FROM => 'lib/Todotxt/Recur.pm',
    EXE_FILES           => [ 'todo-recur' ],
    PREREQ_PM => {
        'Test::Harness'     => 2.50, # Something reasonably newish
        'Test::More'        => 0,
		'Test::Class'	=> 0.36
    },

);
