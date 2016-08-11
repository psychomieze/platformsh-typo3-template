.ONESHELL:
.PHONY:
devpush:
	DIRTY=0
	cd htdocs
	pushd .
	cd vendor/helhum/typo3-console
	if git commit -a; then git push && DIRTY=1; fi
	popd
	pushd .
	cd typo3_src
	if git commit -a; then git push && DIRTY=1; fi
	popd
	[ $$DIRTY -eq 1 ] && COMPOSER_PROCESS_TIMEOUT=2000 composer update --ignore-platform-reqs --prefer-source
	git commit -a && git push

.PHONY:
deploylog: devpush
	platform ssh -- 'less /var/log/deploy.log'
