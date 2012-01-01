package Tests::Match;

use Test::Class;
use base qw(Test::Class);
use Test::More;
use Data::Dumper;

use Todotxt::Recur;

sub same
{
    my ($recurText, $taskText) = @_;

    my $rt = Todotxt::Recur->new($recurText);

    ok($rt->sameTask($taskText), "'$recurText' should match '$taskText'");
}

sub different
{
    my ($recurText, $taskText) = @_;

    my $rt = Todotxt::Recur->new($recurText);

    ok(! $rt->sameTask($taskText), "'$recurText' should not match '$taskText'");
}

sub test_trivial : Test(2) {
    same("sunday: do a thing", "do a thing");
    different("sunday: do a thing", "do another thing");
};

sub test_ignoreContextInTask : Test {
    same("sunday: do a thing", 'do a thing @home');
};

sub test_ignoreDiffContexts : Test {
    same('sunday: do a thing @work', 'do a thing @home');
};

sub test_ignoreProject : Test {
    same("sunday: do a thing", 'do a thing +skynet');
};

sub test_ignoreDiffProjects : Test {
    same('sunday: do a thing +deathstar', 'do a thing +skynet');
};

sub test_ignoreMultiple: Test(2) {
    same('sunday: do a thing +deathstar +skynet @home @road', 'do a thing +skynet +elsewhere @home @work');
    different('sunday: do a thing +deathstar +skynet @home @road', 'do some thing +skynet +elsewhere @home @work');
};

sub test_ignorePriority: Test(3) {
    same('sunday: (A) do a thing', 'do a thing');
    same('sunday: do a thing', '(B) do a thing');
    same('sunday: (A) do a thing', '(C) do a thing');
};

sub test_ignoreDate: Test {
    same('sunday: do a thing', '2013-04-12 do a thing');
};

sub test_ignoreScheduleDate: Test {
    same('sunday: do a thing', 'do a thing t:2011-01-01');
};

1;
