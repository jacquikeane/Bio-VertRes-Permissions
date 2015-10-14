#!/usr/bin/env perl
use strict;
use warnings;
use Data::Dumper;
use Test::Files;

BEGIN { unshift( @INC, './lib' ) }

BEGIN {
    use Test::Most;
    use_ok('Bio::VertRes::Permissions::Groups');
}

ok(my $obj = Bio::VertRes::Permissions::Groups->new(), 'initialise obj');
ok(my $groups = $obj->groups(),'get groups');
is(1, $obj->is_member_of_group($groups->[0]),'Found group');

done_testing();
