
CONFIG_HOME = $$HOME/.dotfiles

ifeq ($(shell uname -s),Darwin)
	lnopts = -sfh
else
	lnopts = -sf
endif

link-all: link-vimrc link-zshrc link-gitconfig link-gnupg
.PHONY: link-all

link-home:
	ln $(lnopts) $(shell pwd) $(CONFIG_HOME)
.PHONY: link-home

link-vimrc: vimrc/vimrc
	ln $(lnopts) $(CONFIG_HOME)/vimrc/vimrc $$HOME/.vimrc
.PHONY: link-vimrc

link-zshrc: zshrc/zshrc
	ln $(lnopts) $(CONFIG_HOME)/zshrc/zshrc $$HOME/.zshrc
.PHONY: link-zshrc

link-gitconfig: gitconfig/gitconfig
	ln $(lnopts) $(CONFIG_HOME)/gitconfig/gitconfig $$HOME/.gitconfig
.PHONY: link-gitconfig

link-gnupg: gnupg/gpg.conf gnupg/gpg-agent.conf
	mkdir $$HOME/.gnupg
	ln $(lnopts) $(CONFIG_HOME)/gnupg/gpg.conf $$HOME/.gnupg/gng.conf
	ln $(lnopts) $(CONFIG_HOME)/gnupg/gpg-agent.conf $$HOME/.gnupg/gpg-agent.conf
.PHONY: link-gnupg

link-i3: config/i3/config
	mkdir -p $$HOME/.config/i3
	ln $(lnopts) $(CONFIG_HOME)/config/i3/config $$HOME/.config/i3/config

clean:
	rm $$HOME/.vimrc
	rm $$HOME/.zshrc
	rm $$HOME/.gitconfig
