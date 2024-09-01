use Test2::V0;
#
use lib '../lib', 'lib';
use Acme::Insult qw[:all];
#
imported_ok qw[adjective insult];
#
subtest 'adjective' => sub {
    ok adjective(),               'generate random adjective';
    ok adjective('en_corporate'), 'generate random corpo-jargon adjective';
    is adjective('garbage'), U(), 'fail to generate random garbage lang adjective';
};
subtest 'insult' => sub {
    is insult(), D(), 'totally random';
    like insult( who => 'Alex' ),                               qr[^Alex is],                   'provide a name';
    like insult( who => 'Peter, Paul, and Mary', plural => 1 ), qr[^Peter, Paul, and Mary are], 'plural';
    is insult( lang => 'en' ),           D(), 'english';
    is insult( lang => 'en_corporate' ), D(), 'corperate lingo';
    like insult( template => 'Jake the <adjective> dog and Finn the <adjective min=1 max=3 id=adj1> <animal>.' ),
        qr[^Jake the .+ dog and Finn the .+$], 'templated insult';
};
#
done_testing;
