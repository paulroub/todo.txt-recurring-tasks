package Todotxt::Recur 1.01;

use strict;
use warnings;
use POSIX;

my %days = (
	    'sunday' => 0,
	    'monday' => 1,
	    'tuesday' => 2,
	    'wednesday' => 3,
	    'thursday' => 4,
	    'friday' => 5,
	    'saturday' => 6
);

my %ordinals = (
		'first' => 1,
		'second' => 2,
		'third' => 4,
		'fourth' => 8,
		'fifth' => 16,
		'last' => 32
);

sub new 
{
    my $this = shift;
    my $class = ref($this) || $this;
    my $self = {};

    $self->{DAILY} = 0;
    $self->{WD} = -1;
    $self->{TASK} = "";
    $self->{WEEKS} = 31;

    bless $self, $class;

    $self->init(@_);

    return $self;
}


sub init
{
    my ($self, $text) = @_;

    if ($text =~ /^\s*(.+?)\s*:\s*(.+?)\s*$/)
      {
	  $self->{TASK} = $2;

	  my $day = lc($1);

	  if ($day eq 'daily')
	    {
		$self->{DAILY} = 1;
		return;
	    }
	  elsif ($day =~ /^((?:(?:first|second|third|fourth|fifth|last)[ \t,]?)+)\s+(.+)$/)
	    {
		my $weeks = 0;

		$day = $2;
		my @parts = split(/[ \t,]+/, $1);

		for my $part (@parts)
		  {
		      $weeks += $ordinals{$part};
		  }

		$self->{WEEKS} = $weeks;
	    }

	  if (defined $days{$day})
	    {
		$self->{WD} = $days{$day};
	    }
	  else
	    {
		die "Can't parse $text\n";
	    }
      }
    elsif ($text =~ /\S/)
      {
	  die "Can't parse $text\n";
      }
}


sub weekday 
{
    my ($self) = @_;

    return $self->{WD};
}

sub task
{
    my ($self) = @_;

    return $self->{TASK};
}

sub weeks
{
    my ($self) = @_;

    return $self->{WEEKS};
}

sub matchDate
{
    my ($self, $date) = @_;

    if ($self->{DAILY})
      {
	  return 1;
      }

    my $time = mktime(0,0,12, $date->[2], $date->[1] - 1, $date->[0] - 1900);
    my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime($time);

    my $matches = ($wday == $self->weekday());

    if ($matches)
      {
	  my $weeks = $self->weeks();

	  my $lasttime = mktime(0, 0, 12, 0, $date->[1], $date->[0] - 1900);
	  my ($lastsec,$lastmin,$lasthour,$lastmday,$lastmon,$lastyear,$lastwday,$lastyday,$lastisdst) = localtime($lasttime);
	  my $isLast = ($mday > ($lastmday - 7));

	  my $whichweek = 1;

	  $mday -= 7;

	  while ($mday > 0)
	    {
		$whichweek *= 2;
		$mday -= 7;
	    }

	  my $wantLast = (($weeks & 32) != 0);

	  $matches = ($wantLast && $isLast) || (($weeks & $whichweek) != 0);
      }

    return $matches;
}

sub stripTask
{
    my ($self, $text) = @_;

    $text = lc($text);

    $text =~ s/^\s*\([a-z]\)\s+//;
    $text =~ s/^\s*\d{4}-\d{1,2}-\d{1,2}\s+//;

    $text =~ s/\s+[\@\+]\w+//g;
    $text =~ s/\s+t:\d{4}-\d{1,2}-\d{1,2}\b//g;
    $text =~ s/\s+/ /g;
    $text =~ s/^ //;
    $text =~ s/ $//;

    return $text;
}

sub sameTask
{
    my ($self, $text) = @_;

    my $strippedOurs = $self->stripTask($self->{TASK});
    my $strippedTheirs = $self->stripTask($text);

    return ($strippedOurs eq $strippedTheirs);
}

1;
