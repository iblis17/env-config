alias h		history 25
alias j		jobs -l
alias la	ls -a
alias lf	ls -Fa
alias ll	ls -la
alias lh	ll -h
alias ls	ls -FGI
alias .		ls
alias ..	cd ../
alias rm	rm -vf
alias cp	cp -R
alias s		screen
alias man	env LC_ALL=C man
alias grep	grep --color
alias du	du -h
alias df	df -h
alias r		screen -r
alias top	top -s 1
alias csupup	csup -g -L 2 /root/supfiles/ports-supfile
alias mysql	mysql -u root -p --prompt="\(\\u\@\\h\)\ \[\\d\]\>"

if (-x /usr/local/bin/bug5) then
	alias telnet bug5 -pu telnet -8
endif
if (-x /usr/local/bin/git) then
	alias gitk git log -p
endif

set	autolist

setenv	LSCOLORS "ExFxcxdxbxegedabagacad"

setenv	TERMCAP 'xterm|xterm-color:Co#256:AB=\E[48;5;%dm:AF=\E[38;5;%dm:tc=xterm-xfree86:'

setenv	LANG en_US.UTF-8
setenv	LC_CTYPE en_US.UTF-8
setenv	LC_COLLATE en_US.UTF-8
setenv	LC_TIME en_US.UTF-8
setenv	LC_NUMERIC en_US.UTF-8
setenv	LC_MONETARY en_US.UTF-8
setenv	LC_MESSAGES en_US.UTF-8
setenv	LC_ALL en_US.UTF-8

#setenv	LANG zh_TW.UTF-8
#setenv	LC_CTYPE zh_TW.UTF-8
#setenv	LC_COLLATE zh_TW.UTF-8
#setenv	LC_TIME zh_TW.UTF-8
#setenv	LC_NUMERIC zh_TW.UTF-8
#setenv	LC_MONETARY zh_TW.UTF-8
#setenv	LC_MESSAGES zh_TW.UTF-8
#setenv	LC_ALL zh_TW.UTF-8

umask	22

set path = (/sbin /bin /usr/sbin /usr/bin /usr/games /usr/local/sbin /usr/local/bin /usr/X11R6/bin $HOME/bin)

if (-x /usr/local/bin/vim) then
	setenv	EDITOR	vim
	alias	vi	vim
else
	setenv	EDITOR	vi
endif
setenv	PAGER	less
setenv	BLOCKSIZE       K
setenv	PACKAGES /usr/ports/packages
setenv	PACKAGESITE ftp://ftp3.tw.freebsd.org/pub/FreeBSD/ports/i386/packages-9-stable/All/

if ( $?prompt ) then
	if ( $USER == root ) then
		set prompt = "%B[%{\033[31m%}%n%{\033[37m%}@%m %~]%# "
	else
		set prompt = "%B[%{\033[36m%}%n%{\033[37m%}@%m %~]%# "
	endif
	set filec
	set history = 5000
	set savehist = 5000
	set mail = (/var/mail/$USER)
	if ( $?tcsh ) then
		bindkey	"^W"	backward-delete-word
		bindkey	"^[[3~"	delete-char-or-list
		bindkey	"^[[2~"	overwrite-mode
		bindkey	"^Z"	run-fg-editor
		bindkey	-k up	history-search-backward
		bindkey	-k down	history-search-forward
	endif
endif


#	Complementation
#
# '@' can substitute '/' in complete
if ( ! $?hosts ) then
	set hosts = (\
				backup \
				cnmc.tw \
				mail \
				ns \
				www \
				)

	foreach key (ssh scp sftp ping ftp)
		complete $key 'p/1/$hosts/'
	end

	complete telnet 'p/1/$hosts/' 'p/2/x:[port]/'
endif

complete cd			'p/1/d/'
complete mkdir		'p/1/d/'
complete alias		'p/1/a/'
complete unalias	'n/*/a/'
complete man		'n/*/c/'
complete where		'n/*/c/'
complete whereis	'n/*/c/'
complete which		'n/*/c/'
complete env		'c/*=/f/' 'p/1/e/=/' 'n/*/c/'
complete set		'c/*=/f/' 'p/1/s/=/'
complete setenv		'p/1/e/'
complete kill		'p/*/`ps | awk \{if\(NR\!=1\)\ print\ \$1\}`/'
complete cc			'p/*/f:*.[cao]/'
complete CC			'p/*/f:*.{c++,cxx,cc,cpp,c,o,cpp}/'
complete ifconfig	'p/1/`ifconfig -l`/' \
					'n/*/(inet inet6 atalk ipx link add alias \
					-alias arp -arp staticarp -staticarp broadcast \
					debug -debug promisc -promisc delete description \
					descr -description -descr down group -group \
					eui64 fib ipdst maclabel media mediaopt \
					-mediaopt mode inst instance name rxcsum \
					-rxcsum txcsum -txcsum tso -tso lro -lro \
					wol wol_ucast wol_mcast wol_magic -wol \
					create destroy list vlanmtu vlanhwtag \
					vlanhwfilter vlanhwtso -vlanmtu -vlanhwtag \
					-vlanhwfilter -vlanhwtso vnet -vnet polling \
					-polling plumb unplumb metric mtu netmask \
					prefixlen range remove phase -link monitor \
					up)/'
complete netstat	'n/-f/(inet inet6 pfkey atalk netgraph ng \
					ipx unix link)/' \
					'n/-p/(divert icmp igmp ip ipsec pim sctp \
					tcp udp icmp6 ip6 ipsec6 rip6 pfkey ddp \
					ctrl data ipx spx)/' \
					'n/-I/`ifconfig -l`/' \
					'c/-/(A a L n S T W x f p M N i I b d h w \
					q s z m B r g Q)/'

#	Ports
if (-x /usr/local/sbin/apachectl) then
	complete apachectl	'p/1/(start stop restart graceful configtest \
						graceful-stop startssl fullstatus status)/'
endif
if (-x /usr/local/bin/php) then
	complete php		'p/*/f:*.php/'
endif
if (-x /usr/local/sbin/postfix) then
	complete postfix	'n/-c/f/' \
						'c/-/(c D v)/' \
						'n/*/(check start abort stop reload status \
						flush upgrade-configuration set-permissions)/'
endif
if (-x /usr/local/bin/sudo) then
	complete sudo		'p/1/(su)/'
endif
if (-x /usr/local/bin/svn) then
	set svncmd =(add blame praise annotate ann cat \
				changelist cl checkout co cleanup commit \
				ci copy cp delete del remove rm diff di \
				export help import info list ls lock log \
				merge mergeinfo mkdir move mv rename ren \
				patch propdel pdel pd propedit pedit pe \
				propget pget, pg proplist plist pl propset \
				pset ps relocate resolve resolved revert \
				status stat st switch sw unlock update up \
				upgrade)
	complete svn		'n/help/$svncmd/' 'p/1/$svncmd/'
endif
if (-x /usr/local/sbin/portmaster) then
	complete portmaster 'n@*=@F:'$PWD/'@' \
						'c/--/(force-config no-confirm no-term-title \
						no-index-fetch index index-first index-only \
						delete-build-only update-if-newer packages \
						packages-only packages-build packages-if-newer \
						always-fetch local-packagedir= packages-local \
						delete-packages show-work list-origins \
						clean-distfiles clean-packages check-depends \
						help version)/'\
						'c/-/(C G H K B b g n t v w f i D d m x P PP \
						a o r R l L F n y e s h)/'\
						'n@*@F:/usr/ports/@'
	alias portupgrade	portmaster
	complete portupgrade	'n/*/`pkg_info | awk \{print\ \$1\}`'
endif

#	TODO
#	psearch
#	git
#	wget
#	fetch
#	curl
#	grep
#	find
#	tar
#	make
