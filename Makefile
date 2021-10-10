DOC_FEATURES=source
TEST_FEATURES=unstable_machinery,builtin_tests,builtin_filters,builtin_functions,source

all: test

build:
	@cargo build --all

doc:
	@RUSTDOCFLAGS=--cfg=docsrs cargo +nightly doc --no-deps --all --features=$(DOC_FEATURES)

test:
	@rustup component add rustfmt 2> /dev/null
	@echo "CARGO TESTS"
	@cd minijinja; cargo test
	@echo "CARGO TEST ALL FEATURES"
	@cd minijinja; cargo test --all-features
	@echo "CARGO TEST MEMCHR"
	@cd minijinja; cargo test --no-default-features --features=memchr,$(TEST_FEATURES)
	@echo "CARGO TEST V_HTMLESCAPE"
	@cd minijinja; cargo test --no-default-features --features=v_htmlescape,$(TEST_FEATURES)
	@echo "CARGO CHECK NO_DEFAULT_FEATURES"
	@cd minijinja; cargo check --no-default-features

check:
	@echo "check no default features:"
	@cd minijinja; cargo check --no-default-features
	@echo "check all features:"
	@cd minijinja; cargo check --all-features

format:
	@rustup component add rustfmt 2> /dev/null
	@cargo fmt --all

format-check:
	@rustup component add rustfmt 2> /dev/null
	@cargo fmt --all -- --check

lint:
	@rustup component add clippy 2> /dev/null
	@cargo clippy --all -- -F clippy::dbg-macro

.PHONY: all doc test format format-check lint check
