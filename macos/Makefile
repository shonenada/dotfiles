MACOS_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

init:
	@$(MACOS_DIR)keyboard-shortcuts.sh
	@$(MACOS_DIR)caps-lock-to-control.sh
	@$(MACOS_DIR)keyboard-repeat.sh
	@$(MACOS_DIR)homebrew.sh
.PHONY: init

keyboard-shortcuts:
	@$(MACOS_DIR)keyboard-shortcuts.sh
.PHONY: keyboard-shortcuts

caps-lock-to-control:
	@$(MACOS_DIR)caps-lock-to-control.sh
.PHONY: caps-lock-to-control

keyboard-repeat:
	@$(MACOS_DIR)keyboard-repeat.sh
.PHONY: keyboard-repeat

homebrew:
	@$(MACOS_DIR)homebrew.sh
.PHONY: homebrew
