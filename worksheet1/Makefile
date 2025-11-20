# Top-level Makefile for OS Worksheet 1 (Task 3)
.PHONY: all build src-build clean src-clean test run help

all: build

# Build (delegates to src/ Makefile)
build: src-build

src-build:
	@echo "==> Building in src/ ..."
	$(MAKE) -C src driver_cli

# Clean (delegates to src/ Makefile)
clean: src-clean

src-clean:
	@echo "==> Cleaning src/ ..."
	$(MAKE) -C src clean

# Smoke tests: build and run non-interactive tests (saves to /tmp)
test: build
	@echo "==> Running non-interactive tests ..."
	@./src/driver_cli task1 > /tmp/task1.txt || true; cat /tmp/task1.txt
	@./src/driver_cli task1.2 > /tmp/task1.2.txt || true; cat /tmp/task1.2.txt
	@./src/driver_cli task2_array > /tmp/task2_array.txt || true; cat /tmp/task2_array.txt
	@printf "ali\n51\n" | ./src/driver_cli task2_name > /tmp/task2_name_51.txt || true
	@echo "task2_name (51) lines:"; grep -c "^Welcome, ali$$" /tmp/task2_name_51.txt || true
	@printf "2\n16\n" | ./src/driver_cli task2_range > /tmp/task2_range_2_16.txt || true; cat /tmp/task2_range_2_16.txt

run:
	@echo "Usage examples:"
	@echo "  ./src/driver_cli task1"
	@echo "  ./src/driver_cli task2_name   (interactive)"
	@echo "  ./src/driver_cli task2_range  (interactive)"

help:
	@echo "Targets:"
	@echo "  make        == make all (builds everything)"
	@echo "  make clean  == clean build artifacts"
	@echo "  make test   == build and run smoke tests"
