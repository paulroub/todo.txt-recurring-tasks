package Tests::Parse;

use Test::Class;
use base qw(Test::Class);
use Test::More;

use Todotxt::Recur;

sub test_simple : Test(3) {
    my $rt = Todotxt::Recur->new("sunday: do a thing");
    
    is($rt->weekday, 0, "weekday");
    is($rt->task, "do a thing", "task");
    is($rt->weeks, 31, "which weeks");
};

sub test_firstMonday : Test(3) {
    my $rt = Todotxt::Recur->new("first monday: do a thing");
    
    is($rt->weekday, 1, "weekday");
    is($rt->task, "do a thing", "task");
    is($rt->weeks, 1, "which weeks");
};

sub test_firstSecond : Test(3) {
    my $rt = Todotxt::Recur->new("first,second tuesday: do a thing");
    
    is($rt->weekday, 2, "weekday");
    is($rt->task, "do a thing", "task");
    is($rt->weeks, 3, "which weeks");
};

sub test_last : Test(3) {
    my $rt = Todotxt::Recur->new(" last  friday : do a thing ");
    
    is($rt->weekday, 5, "weekday");
    is($rt->task, "do a thing", "task");
    is($rt->weeks, 32, "which weeks");
};

sub test_dieOnGarbage : Test {
    my $failed = 0;

    eval {
	my $rt = Todotxt::Recur->new("frunsday: what?");
    } or do {
	$failed = 1;
    };

    ok($failed, "expected failure");
};

1;
