package Todotxt::Recur;

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

	  if ($day =~ /^((?:(?:first|second|third|fourth|fifth|last)[ \t,]?)+)\s+(.+)$/)
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

sub match
{
    my ($self, $date) = @_;
    
    return 0;
}

1;
