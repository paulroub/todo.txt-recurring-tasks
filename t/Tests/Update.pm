package Tests::Update;

use Test::Class;
use base qw(Test::Class);
use Test::More;

use Todotxt::Recur;
use Todotxt::Recurlist;

my $recurlist = [
		 'monday: (A) recycling out',
		 'friday: (A) garbage out',
		 'tuesday: garbage out',
		 'first saturday: change A/C filters',
		 'last sunday: dog\'s heartworm medicine'
];

sub checkAdds
{
    my ($todolist, $expected, $date) = @_;
    my @problems = ();

    my $rlist = Todotxt::Recurlist->new($todolist, $recurlist);

    my @got = @{ $rlist->addList($date) };

    my %inExpected = map { $_ => 1 } @$expected;
    my %inGot = map { $_ => 1 } @got;

    for my $task (keys %inExpected) 
      {
	  if (! defined $inGot{$task})
	    {
		push @problems, "Expected $task";
	    }
      }
    for my $task (keys %inGot) 
      {
	  if (! defined $inExpected{$task})
	    {
		push @problems, "Unexpected $task";
	    }
      }

    ok((@problems == 0), join("\n", @problems));
}

sub test_trivial : Test(2) {
    checkAdds( [], [], [2012,1,1] );
    checkAdds( [], ['garbage out'], [2012,1,3] );
};

sub test_everyMonday: Test(2) {
    checkAdds( [], ['(A) recycling out'], [2012,1,2], 1 );
    checkAdds( [], ['(A) recycling out'], [2012,1,9] );
};

sub test_ignoreOther: Test {
    checkAdds( ['other thing'], ['(A) recycling out'], [2012,1,2] );
}

sub test_skipExisting: Test {
    checkAdds( ['2012-01-01 recycling out'], [], [2012,1,2] );
}

sub test_ignoreDone: Test {
    checkAdds( ['x recycling out'], ['(A) recycling out'], [2012,1,2] );
}


1;
