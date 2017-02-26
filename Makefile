
CONFIG_HOME = $$HOME/.dotfiles

ifeq ($(shell uname -s),Darwin)
	lnopts = -sfh
else
	lnopts = -sf
endif

link-all: link-vimrc link-zshrc link-gitconfig link-gnupg
.PHONY: link-all

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

clean:
	rm $$HOME/.vimrc
	rm $$HOME/.zshrc
	rm $$HOME/.gitconfig
