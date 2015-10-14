package Bio::VertRes::Permissions::Groups;

# ABSTRACT:  Groups for the current user

=head1 SYNOPSIS

Groups for the current user
   use Bio::VertRes::Permissions::Groups;
   
   my $obj = Bio::VertRes::Permissions::Groups->new();
   $obj->groups();
   $obj->is_member_of_group();

=cut

use Moose;

has 'groups' => ( is => 'ro', isa => 'ArrayRef', lazy => 1, builder => '_build_groups' );

sub _build_groups {
    my ($self) = @_;
	# Unix::Groups fails to compile on OSX mountain lion
	my $raw_groups_output = `groups`;
	my @groups = split(/[\s\t]/, $raw_groups_output);
    return \@groups;
}

sub is_member_of_group {
    my ( $self, $input_group ) = @_;
    if ( grep { $_ eq $input_group } @{ $self->groups } ) {
        return 1;
    }
    else {
        return 0;
    }
}

no Moose;
__PACKAGE__->meta->make_immutable;

1;
