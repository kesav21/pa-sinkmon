CC=gcc
CFLAGS=-lm -D_REENTRANT -lpulse -pthread

.DEFAULT_GOAL := install
.PHONY: install
install: sinkmon
	@cp sinkmon ~/.local/bin

.PHONY: uninstall
uninstall:
	@rm -f ~/.local/bin/sinkmon

.PHONY: clean
clean:
	@rm src/obj/*.o
	@rm sinkmon

sinkmon: src/obj/main.o src/obj/callbacks.o src/obj/utils.o
	@$(CC) $(CFLAGS) $^ -o $@

src/obj/main.o: src/main.c src/data.h src/callbacks.h
	@$(CC) $< -c -o $@

src/obj/callbacks.o: src/callbacks.c src/data.h src/utils.h src/callbacks.h
	@$(CC) $< -c -o $@

src/obj/utils.o: src/utils.c src/utils.h
	@$(CC) $< -c -o $@
