TERMUX_PKG_HOMEPAGE=https://metasploit.com/
TERMUX_PKG_DESCRIPTION="Open source penetration testing framework"
TERMUX_PKG_VERSION=4.16.5
TERMUX_PKG_DEPENDS="autoconf, bison, clang, coreutils, curl, findutils, git, apr, apr-util, libffi-dev, libgmp-dev, libpcap-dev, postgresql-dev, readline-dev, libsqlite-dev, openssl-dev, libtool, libxml2-dev, libxslt-dev, ncurses-dev, pkg-config, postgresql-contrib, wget, make, ruby-dev, libgrpc-dev, termux-tools, ncurses-utils, ncurses, unzip, zip, tar"

termux_step_make_install () {
	echo "make install"
	cd $TERMUX_PREFIX/share/

	rm -rf $TERMUX_PREFIX/share/metasploit-framework
	git clone https://github.com/rapid7/metasploit-framework --depth 1 
	cd $TERMUX_PREFIX/share/metasploit-framework

	# Remove data directory for now to avoid termux-elf-cleaner running on it
	rm -rf data

	# Skip rbnacl
	sed '/rbnacl/d' -i Gemfile.lock
	sed '/rbnacl/d' -i metasploit-framework.gemspec

	# Skip grpc
	sed '/grpc/d' -i Gemfile.lock
	sed '/grpc/d' -i metasploit-framework.gemspec

	#for MSF in $(ls msf*); do ln -s $MSF $TERMUX_PREFIX/bin/$MSF;done
}

termux_step_post_massage () {
	echo "post massage"
	cd $TERMUX_PREFIX/share/metasploit-framework

	# put the data directory back
	git checkout -- data/

	gem install bundler -i $TERMUX_PREFIX/lib/ruby/gems/2.3.0
	gem install nokogiri -i $TERMUX_PREFIX/lib/ruby/gems/2.3.0 -- --use-system-libraries 
}
