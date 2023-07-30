build:
	@rm -rf Homefay.xcodeproj
	@xcodegen generate
	@open Homefay.xcodeproj
