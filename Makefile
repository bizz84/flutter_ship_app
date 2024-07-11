# Makefile for deploying the Flutter web project to GitHub

OWNER = bizz84
NAME = flutter_ship_app_web
BASE_HREF = /$(NAME)/
GITHUB_REPO = https://github.com/$(OWNER)/$(NAME)
BUILD_VERSION := $(shell grep 'version:' pubspec.yaml | awk '{print $$2}')
SENTRY_PROJECT_SLUG = flutter-ship-app

# Deploy the Flutter web project to GitHub
deploy:
	@echo "Clean existing repository"
#	flutter clean

	@echo "Getting packages..."
#	flutter pub get

	@echo "Running generators..."
#	dart run build_runner -d

	@echo "Building for web..."
	flutter build web --dart-define-from-file=api-keys.prod.json --base-href $(BASE_HREF) --release --source-maps

	@echo "Deploying to git repository"
	cd build/web && \
	rm -rf .git/ && \
	git init && \
	git add . && \
	git commit -m "Deploy Version $(BUILD_VERSION)" && \
	git branch -M main && \
	git remote add origin $(GITHUB_REPO) && \
	git push -u -f origin main

	@echo -e "Uploading sourcemaps for $(BUILD_VERSION)"
	sentry-cli releases new --project $(SENTRY_PROJECT_SLUG) $(BUILD_VERSION)
	sentry-cli releases files $(BUILD_VERSION) upload-sourcemaps . \
			--project $(SENTRY_PROJECT_SLUG) \
  	  --ext dart \
    	--rewrite
	sentry-cli releases files $(BUILD_VERSION) upload-sourcemaps ./build/web/main.dart.js.map --project $(SENTRY_PROJECT_SLUG)
	sentry-cli releases finalize $(BUILD_VERSION) --project $(SENTRY_PROJECT_SLUG)

	cd ../..
	@echo "✅ Finished deploy: $(GITHUB_REPO)"
	@echo "🚀 Flutter web URL: https://$(OWNER).github.io/$(NAME)/"

.PHONY: deploy
