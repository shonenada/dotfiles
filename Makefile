
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

link-zellij:
	mkdir -p $$HOME/.config/zellij/
	ln $(lnopts) $(CONFIG_HOME)/zellij/config.kdl $$HOME/.config/zellij/config.kdl
.PHONY: link-zellij

link-gnupg: gnupg/gpg.conf gnupg/gpg-agent.conf
	mkdir $$HOME/.gnupg
	ln $(lnopts) $(CONFIG_HOME)/gnupg/gpg.conf $$HOME/.gnupg/gng.conf
	ln $(lnopts) $(CONFIG_HOME)/gnupg/gpg-agent.conf $$HOME/.gnupg/gpg-agent.conf
.PHONY: link-gnupg

link-i3: config/i3/config
	mkdir -p $$HOME/.config/i3
	ln $(lnopts) $(CONFIG_HOME)/config/i3/config $$HOME/.config/i3/config

link-xinitrc: config/xorg/xinitrc
	ln $(lnopts) $(CONFIG_HOME)/config/xorg/xinitrc $$HOME/.xinitrc

link-keymap: config/xorg/Xmodmap
	ln $(lnopts) $(CONFIG_HOME)/config/xorg/Xmodmap $$HOME/.Xmodmap

link-polybar: config/polybar
	ln $(lnopts) $(CONFIG_HOME)/config/polybar $$HOME/.config/polybar

link-bin-git-biu: bin/git-biu
	ln $(lnopts) $(CONFIG_HOME)/bin/git-biu /usr/local/bin/git-biu


clean:
	rm $$HOME/.vimrc
	rm $$HOME/.zshrc
	rm $$HOME/.gitconfig
