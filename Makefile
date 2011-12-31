test:
	perl  "-MExtUtils::Command::MM" -e "test_harness(0,lib,t)" t/*.t
