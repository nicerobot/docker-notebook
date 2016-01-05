#!/bin/bash -xv

[ "$1" = "notebook" ] && {
	jupyter ${*}
	exit $?
}

exec "$@"
