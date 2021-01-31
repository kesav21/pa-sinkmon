CC=gcc
CFLAGS=-lm -D_REENTRANT -lpulse -pthread

bin/sinkmon: src/obj/main.o src/obj/callbacks.o src/obj/utils.o
	$(CC) $(CFLAGS) $^ -o $@

src/obj/main.o: src/main.c src/data.h src/callbacks.h
	$(CC) $< -c -o $@

src/obj/callbacks.o: src/callbacks.c src/data.h src/utils.h src/callbacks.h
	$(CC) $< -c -o $@

src/obj/utils.o: src/utils.c src/utils.h
	$(CC) $< -c -o $@

.PHONY: clean install uninstall

clean:
	rm src/obj/*.o

install:
	ln -svf `pwd`/bin ~/.local/bin/audio

uninstall:
	unlink ~/.local/bin/audio
