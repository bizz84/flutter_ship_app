# Makefile for deploying the Flutter web project to GitHub

OWNER = bizz84
NAME = flutter_ship_app_web
BASE_HREF = /$(NAME)/
GITHUB_REPO = https://github.com/$(OWNER)/$(NAME)
BUILD_VERSION := $(shell grep 'version:' pubspec.yaml | awk '{print $$2}')

# Deploy the Flutter web project to GitHub
deploy:
	@echo "Clean existing repository"
#	flutter clean

	@echo "Getting packages..."
#	flutter pub get

	@echo "Running generators..."
#	dart run build_runner -d

	@echo "Building for web..."
	flutter build web --dart-define-from-file=api-keys.prod.json --base-href $(BASE_HREF) --release

	@echo "Deploying to git repository"
	cd build/web && \
	rm -rf .git/ && \
	git init && \
	git add . && \
	git commit -m "Deploy Version $(BUILD_VERSION)" && \
	git branch -M main && \
	git remote add origin $(GITHUB_REPO) && \
	git push -u -f origin main

	cd ../..
	@echo "✅ Finished deploy: $(GITHUB_REPO)"
	@echo "🚀 Flutter web URL: https://$(OWNER).github.io/$(NAME)/"

.PHONY: deploy
