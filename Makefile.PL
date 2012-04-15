use ExtUtils::MakeMaker;

WriteMakefile(
	NAME	=> 'Todotxt::Recur',
	ABSTRACT => 'Recurring-tasks maintenance for todo.txt',
	AUTHOR => 'Paul Roub <paul@roub.net>',
	VERSION_FROM => 'lib/Todotxt/Recur.pm',
	INSTALLSITESCRIPT => $ENV{'HOME'} . "/.todo.actions.d",
    EXE_FILES           => [ 'recur' ],
	MIN_PERL_VERSION => '5.8.8',
    PREREQ_PM => {
        'Test::Harness'     => 2.50, # Something reasonably newish
        'Test::More'        => 0,
		'Test::Class'	=> 0.36
    },
);
