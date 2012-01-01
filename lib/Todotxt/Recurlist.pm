package Todotxt::Recurlist;

use strict;
use warnings;
use POSIX;

use Todotxt::Recur;

sub new 
{
    my $this = shift;
    my $class = ref($this) || $this;
    my $self = {};

    bless $self, $class;
    $self->init(@_);

    return $self;
}


sub init
{
    my ($self, $todolist, $recurlist) = @_;

    $self->{LIST} = $todolist;
    $self->{RECUR} = $recurlist;
}

sub addList
{
    my ($self, $date) = @_;
    my @candidates = ();
    my @toadd = ();

    for my $recur (@{ $self->{RECUR} })
      {
	  my $rt = Todotxt::Recur->new($recur);

	  if ($rt->matchDate($date))
	    {
		push @candidates, $rt;
	    }
      }

    for my $recur (@candidates)
      {
	  my $found = 0;

	  for my $task (@{ $self->{LIST} })
	    {
		if ($recur->sameTask($task))
		  {
		      $found = 1;
		      last;
		  }
	    }

	  if (! $found)
	    {
		push @toadd, $recur->task();
	    }
      }

    return \@toadd;
}

1;
