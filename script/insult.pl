use lib '../lib';
use v5.36;
use Acme::Insult;
use Getopt::Long;
use Pod::Usage;
use open qw[:std :encoding(UTF-8)];

# Test
#~ @ARGV = qw[];
#~ @ARGV = qw[-j];
#~ @ARGV = qw[-who Tim];
#~ @ARGV = ( qw[-plural -who], 'Tim and John' );
#~ @ARGV = (qw[-adjective -sfw]);
#~ @ARGV = (qw[-sfw]);
#~ @ARGV = qw[-h];
#
my $raw = 0;

sub _echo ($slip) {    # JSON::Tiny is loaded in Acme::Free::Advice::Unsolicited anyway
    $raw ? JSON::Tiny::encode_json($slip) : $slip;
}
GetOptions( \my %h, 'who=s', 'template=s', 'plural!', 'help' => sub { pod2usage( -exitval => 1 ) }, 'json!' => \$raw, 'adjective!', 'sfw!' );
$h{lang} = 'en_corporate' if delete $h{sfw};
my $shade
    = delete $h{adjective} ? ( $raw ? Acme::Insult::_adjective( $h{lang} ) : Acme::Insult::adjective( $h{lang} ) ) :
    $raw                   ? Acme::Insult::_insult(%h) :
    Acme::Insult::insult(%h);
exit !( $shade ? say _echo($shade) : !say( $raw ? 'null' : '' ) );
__END__

=head1 NAME

insult - Generate insults on the terminal

=head1 SYNOPSIS

    insult                                  # generate a random insult
    insult -template='...'                  # generate insults with a specific format
    insult -json                            # insult someone if you're a robot
    insult -who John                        # insult someone by name
    insult -plural -who "John and Alex"     # insult multiple people
    insult -sfw                             # insult someone with workplace jargon
    insult -adjective                       # generate a single adjective
    insult -help                            # get help

=head1 OPTIONS

    -json               Echo raw JSON encoded data
    -template <layout>  Specify an insult's format
    -who                Provide a name for the person you'd like to insult
    -plural             Changes the template to third person plural
    -sfw                Use corporate jargon to generate insults
    -adjective          Generates a single adjective in plain text
    -help               Display this help message

=head1 DESCRIPTION

This script wraps Acme::Insult.

=head1 LICENSE & LEGAL

Copyright (C) Sanko Robinson.

This library is free software; you can redistribute it and/or modify it under the terms found in the Artistic License
2. Other copyrights, terms, and conditions may apply to data transmitted through this module.

Unsolicited advice provided by L<Kevin Kelly|https://kk.org/>.

=head1 AUTHOR

Sanko Robinson E<lt>sanko@cpan.orgE<gt>

=cut
