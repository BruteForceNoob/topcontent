PHONY: bld deploy

bld:
	flutter build web --web-renderer html --release
	cp ./build/web/index.html ./functions/index.html 

deploy:
    firebase deploy