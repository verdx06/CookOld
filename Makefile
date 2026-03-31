.default: generate

bootstrap:
	mint bootstrap

hook:
	git config --local core.hooksPath .githooks
	chmod +x .githooks/post-checkout
	chmod +x .githooks/post-merge

xcgen: generate

generate:
	mint run xcodegen xcodegen generate --spec project.yml

open:
	open ./CulinarApp.xcodeproj
