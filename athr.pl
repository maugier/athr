#!/usr/bin/env perl

use Data::Dumper;

#== CONFIG START==

my $nickserv = "NickServ";
my $chanserv = "ChanServ";
my $hostserv = "HostServ";

#== CONFIG END==

my $nicks;
my $chans;

my $nick_re = qr/[^\s]+/;
my $vhost_re = qr/[a-zA-Z0-9.-]+/;
my $email_re = qr/[^\s]+/;
my $chan_re = qr/[^\s]+/;

while(<>) {
    if (m/$hostserv> ($nick_re) ACTIVATE: ($vhost_re) for ($nick_re)/o) {
        $nicks->{$3}{'vhosts'}{$2} = 1;    
    } elsif (m/$nickserv> ($nick_re) REGISTER: ($nick_re) to ($email_re)/o) {
        $nicks->{$2}{'email'} = $3
    } elsif (m/$nickserv> ($nick_re) \(($nick_re)\) GROUP: ($nick_re) to ($nick_re)/o) {
        $nicks->{$4}{'grouped'}{$4} = 1;
    } elsif (m/$nickserv> ($nick_re) F?DROP: ($nick_re)/o) {
        delete $nicks->{$2};
    } elsif (m/$chanserv> ($nick_re) DROP: ($chan_re)/o) {
        delete $chans->{$2};
    }
}

print Dumper({ nicks => $nicks, chans => $chans });
