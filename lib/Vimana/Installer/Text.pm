package Vimana::Installer::Text;
use warnings;
use strict;
use base qw(Vimana::Installer);
use Vimana::Logger;
use Vimana::VimballInstall;

sub new { bless {}, shift; }

sub run {
    my ( $class, $pkgfile ) = @_;

    if( $pkgfile->is_vimball ) {
        $logger->info("Found Vimball File");
        my $install = Vimana::VimballInstall->new({ package => $pkgfile });
        $install->run();
        return 1;
    }

    # known types (depends on the information that vim.org provides.
    return $pkgfile->copy_to_rtp( 'colors' )
        if $pkgfile->script_is('color scheme');

    return $pkgfile->copy_to_rtp( 'syntax' )
        if $pkgfile->script_is('syntax');

    return $pkgfile->copy_to_rtp( 'indent' )
        if $pkgfile->script_is('indent');

    return $pkgfile->copy_to_rtp( 'ftplugin' )
        if $pkgfile->script_is('ftplugin');

    # guess text filetype here.  (colorscheme, ftplugin ...etc)

}

1;