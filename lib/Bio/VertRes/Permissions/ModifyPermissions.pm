package Bio::VertRes::Permissions::ModifyPermissions;
# ABSTRACT:  Take in a list of directories and update the permissions and owners of all files

=head1 SYNOPSIS

Take in a list of directories and update the permissions and owners of all files
   use Bio::VertRes::Permissions::ModifyPermissions;
   
   my $obj = Bio::VertRes::Permissions::ModifyPermissions->new(input_directories => \@directories, user => 'xyz', group => 'abc', octal_permissions => '750');
   $obj->update_permissions;


=cut

use Moose;
use Parallel::ForkManager;
use File::Find;

has 'input_directories' => (
    is  => 'ro',
    isa => 'ArrayRef',
    required => 1 );
has 'threads'           => ( is => 'ro', isa => 'Int', default  => 1 );
has 'verbose'           => ( is => 'ro', isa => 'Bool', default  => 0 );
has 'group'             => ( is => 'ro', isa => 'Str', required  => 0 );
has 'user'              => ( is => 'ro', isa => 'Str', required  => 0 );
has 'octal_permissions' => ( is => 'ro', isa => 'Str', default  => '0750' );

sub _wanted {
  my $self = ${$_[0]}{self};
  return unless(defined $File::Find::name);
  
  if($self->verbose)
  {
	  print $File::Find::name."\n";
  }

  my $uid = getpwnam $self->user;
  my $gid = getgrnam $self->group; 
  
  chmod oct($self->octal_permissions), $File::Find::name;
  chown $uid, $gid, $_;
}

sub update_permissions {
    my ($self) = @_;
	
	my $pm = new Parallel::ForkManager($self->threads); 
	for my $directory (@{$self->input_directories})
	{
		$pm->start and next;
		
		find({ wanted => sub {
        _wanted({self => $self});
      }
	  , follow => 1 }, $directory);
		$pm->finish;
	}
	$pm->wait_all_children;
	return $self;
}


no Moose;
__PACKAGE__->meta->make_immutable;

1;
