
# PulseAudio Sink Monitor

This project contains a program I use to monitor the different sinks connected to my computer.
The daemon, written in C, interfaces with PulseAudio directly and writes its results to certain files.
Then, scripts can be written to read and interpret these files.

## Daemon

The daemon is responsible for the following:
- Maintaining an always up-to-date reference to the newest sink
- Maintaining always up-to-date information on all sinks
- Notifying on sink change
- Switching sink-inputs on sink change

## Usage

- Compile the daemon
	```sh
	make
	```
- Run the daemon as a background process
	```sh
	sinkmon &
	```
- Install the daemon (the default location is `~/.local/bin`)
	```sh
	make install
	```

## Related Reading

- [Code gist](https://gist.github.com/jasonwhite/1df6ee4b5039358701d2)
- [Official PulseAudio documentation](https://freedesktop.org/software/pulseaudio/doxygen/)

## TODO

- [create a custom pulseaudio module](https://www.freedesktop.org/wiki/Software/PulseAudio/Documentation/Developer/Modules/)

