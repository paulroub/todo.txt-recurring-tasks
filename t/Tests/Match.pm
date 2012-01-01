package Tests::Match;

use Test::Class;
use base qw(Test::Class);
use Test::More;

use Todotxt::Recur;

sub test_simple : Test {
    my $rt = Todotxt::Recur->new("sunday: do a thing");
    my $dt = [2012,1,1];

    ok($rt->matchDate($dt), "2012-01-01 is a sunday");
};

sub test_firstMonday : Test(2) {
    my $rt = Todotxt::Recur->new("first monday: do a thing");
    my $dt = [2012,1,2];

    ok($rt->matchDate($dt), "2012-01-02 is a first monday");
    ok(! $rt->matchDate([2012,1,9]), "2012-01-09 is not a first monday");
};

sub test_firstSecond : Test(3) {
    my $rt = Todotxt::Recur->new("first,second tuesday: do a thing");
    
    ok($rt->matchDate([2012,1,3]), "2012-01-03 is a first tuesday");
    ok($rt->matchDate([2012,1,10]), "2012-01-10 is a second tuesday");
    ok(! $rt->matchDate([2012,1,17]), "2012-01-17 is neither first nor second");
};

sub test_last : Test(2) {
    my $rt = Todotxt::Recur->new(" last  friday : do a thing ");

    ok(! $rt->matchDate([2012,1,20]), "2012-01-20 is not last friday");
    ok($rt->matchDate([2012,1,27]), "2012-01-27 is last friday");
};

1;

