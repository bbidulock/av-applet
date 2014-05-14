#!/usr/bin/perl -w

use ExtUtils::MakeMaker;
my $VERSION = '0.01';
if (-d ".git") {
	$VERSION = `git describe --tags`;
	$VERSION =~ s/-.*//;
}

WriteMakefile(
	NAME => q(av-applet),
	VERSION => $VERSION,
	LICENSE => 'perl',
	EXE_FILES => [qw(
		av-applet
		avahi-rfb-selector
		avahi-snmp-selector
		avahi-ssh-selector
	)],
	PREREQ_PM => {
		'Getopt::Long' => 0.00,
		'Glib' => 0.00,
		'Gtk2' => 0.00,
		'Gtk2::Unique' => 0.00,
		'Net::DBus' => 0.00,
		'Net::DBus::GLib' => 0.00,
	},
	# basically strip the pod out of the .pm file and squeeze blank lines
	PM_FILTER => qq{(sed '/^=[^c]/,/^=cut/d'|cat -s)},
);

sub MY::postamble {
	return <<MAKE_FRAG;

.PHONY: install_desktop
install:: install_desktop

install_desktop:
	install -Dm644 av-applet.desktop "\$(DESTDIR)/etc/xdg/autostart/av-applet.desktop"
	install -Dm644 av-applet.desktop "\$(DESTDIR)/usr/share/applications/av-applet.desktop"
	install -Dm644 avahi-rfb-selector.desktop "\$(DESTDIR)/usr/share/applications/avahi-rfb-selector.desktop"
	install -Dm644 avahi-snmp-selector.desktop "\$(DESTDIR)/usr/share/applications/avahi-snmp-selector.desktop"
	install -Dm644 avahi-ssh-selector.desktop "\$(DESTDIR)/usr/share/applications/avahi-ssh-selector.desktop"

MAKE_FRAG
}
