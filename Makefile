all: compile

compile:
	erlc -o ebin/ src/*.erl test/*.erl

clean:
	rm -f ebin/*
