use strict;
use warnings;

use Test::More;
if ($ENV{RUN_MAINTAINER_TESTS}) {
    plan 'tests' => 3;
} else {
    plan 'skip_all' => 'Module maintainer tests';
}

SKIP: {
    if (! eval 'use Test::Pod 1.26; 1') {
        skip('Test::Pod 1.26 required for testing POD', 1);
    }

    pod_file_ok('lib/threads.pm');
}

SKIP: {
    if (! eval 'use Test::Pod::Coverage 1.08; 1') {
        skip('Test::Pod::Coverage 1.08 required for testing POD coverage', 1);
    }

    pod_coverage_ok('threads',
                    {
                        'trustme' => [
                            qr/^new$/,
                            qr/^exit$/,
                            qr/^async$/,
                            qr/^\(/,
                            qr/^(all|running|joinable)$/,
                        ],
                        'private' => [
                            qr/^import$/,
                            qr/^DESTROY$/,
                            qr/^bootstrap$/,
                        ]
                    }
    );
}

SKIP: {
    if (! eval 'use Test::Spelling; 1') {
        skip('Test::Spelling required for testing POD spelling', 1);
    }
    if (system('aspell help >/dev/null 2>&1')) {
        skip(q/'aspell' required for testing POD spelling/, 1);
    }
    set_spell_cmd('aspell list --lang=en');
    add_stopwords(<DATA>);
    pod_file_spelling_ok('lib/threads.pm', 'thread.pm spelling');
    unlink("/home/$ENV{'USER'}/en.prepl", "/home/$ENV{'USER'}/en.pws");
}

exit(0);

__DATA__

API
async
cpan
MSWin32
pthreads
SIGTERM
TID
Config.pm

Hedden
Artur
Soderberg
crystalflame
brecon
netrus
Rocco
Caputo
netrus
vipul
Ved
Prakash
presicient

okay
unjoinable
incrementing

MetaCPAN
__END__
