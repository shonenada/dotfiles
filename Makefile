
CONFIG_HOME = $$HOME/.config

link-all: link-vimrc link-zshrc link-gitconfig link-gnupg
.PHONY: link-all

link-vimrc: vimrc/vimrc
	ln -sfh $$CONFIG_HOME/vimrc/vimrc $$HOME/.vimrc
.PHONY: link-vimrc

link-zshrc: zshrc/zshrc
	ln -sfh $$CONFIG_HOME/zshrc/zshrc $$HOME/.zshrc
.PHONY: link-zshrc

link-gitconfig: gitconfig/gitconfig
	ln -sfh $$CONFIG_HOME/gitconfig/gitconfig $$HOME/.gitconfig
.PHONY: link-gitconfig

link-gnupg: gnupg/gpg.conf gnupg/gpg-agent.conf
	mkdir $$HOME/.gnupg
	ln -sfh $$CONFIG_HOME/gnupg/gpg.conf $$HOME/.gnupg/gng.conf
	ln -sfh $$CONFIG_HOME/gnupg/gpg-agent.conf $$HOME/.gnupg/gpg-agent.conf
.PHONY: link-gnupg
