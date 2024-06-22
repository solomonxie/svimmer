#######################################################################
#                         VIM - make install                          #
#######################################################################
-include envfile
-include envfile-local

DOTFILES ?= ~/dotfiles
MYOS ?= `cat /tmp/env-os`
USER ?= `cat /tmp/env-user`

# This recipe is for solo-installment, not for "parent" Makefile
install:
	$(MAKE) ${MYOS}

checkhealth:
	python3 -V
	pip3 -V
	npm -v

install-mac: checkhealth_mac
	brew --version
	brew install vim
	brew install neovim
	brew install ctags
	# brew install --HEAD universal-ctags/universal-ctags/universal-ctags

install-debian: checkhealth_debian
	sudo apt-get --version
	sudo apt-get install vim -y
	sudo apt-get install ctags -y

ubuntu: debian
raspbian: debian


install-dependencies: checkhealth
	pip3 install -r ./requirements.txt
	cat ./package.txt |xargs npm install -g
