#!/usr/bin/env perl

use Data::Dumper;

#== CONFIG START==

my $nickserv = "NickServ";
my $chanserv = "ChanServ";
my $hostserv = "HostServ";

#== CONFIG END==

my $vhosts;
my $nicks;

my $nick_re = qr/[^ ]+/;
my $vhost_re = qr/[a-zA-Z0-9.-]+/;
my $email_re = qr/([^\s])+/;

while(<>) {
    if (m/$hostserv> ($nick_re) ACTIVATE ($vhost_re) for ($nick_re)/o) {
        $vhosts->{$3}{$2} = 1;    
    } elsif (m/$nickserv> ($nick_re) REGISTER: ($nick_re) to ($email_re)/o) {
        $nicks->{$2} = $3
    } 
}

print Dumper({ nicks => $nicks, vhosts => $vhosts });
