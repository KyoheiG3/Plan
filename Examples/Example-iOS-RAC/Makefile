carthageModule :=

# XcodeGen

.PHONY: run-xcodegen
run-xcodegen:
	xcodegen

# Carthage

.PHONY: bootstrap-carthage
bootstrap-carthage:
	carthage bootstrap --platform ios --use-ssh --no-use-binaries --cache-builds

.PHONY: update-carthage
update-carthage:
	carthage update --platform ios --use-ssh --no-use-binaries --cache-builds ${carthageModule}

.PHONY: renew-carthage
renew-carthage:
	carthage update --platform ios --use-ssh --no-use-binaries
