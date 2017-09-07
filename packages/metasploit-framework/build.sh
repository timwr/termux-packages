TERMUX_PKG_HOMEPAGE=https://www.metasploit.com/
TERMUX_PKG_DESCRIPTION="The metasploit framework is an open source computer security project that provides information about security vulnerabilities and aids in penetration testing and IDS signature development"
TERMUX_PKG_VERSION=4.16.2
TERMUX_PKG_SRCURL=https://github.com/rapid7/metasploit-framework/archive/${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=564072e633da3243252c3eb2cd005e406c005e0e4bbff56b22f7ae0640a3ee34
TERMUX_PKG_FOLDERNAME=metasploit-framework-$TERMUX_PKG_VERSION
TERMUX_PKG_BUILD_IN_SRC=yes

termux_step_configure () {
	return
}

termux_step_make () {
    export GEM_HOME=$TERMUX_PREFIX/lib/ruby/gems/2.3.0/
    gem install bundler
    gem install sqlite3-ruby
    $GEM_HOME/bin/bundle
}

termux_step_make_install () {
	return
}
