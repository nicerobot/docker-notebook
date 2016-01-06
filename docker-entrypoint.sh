#!/bin/bash -xv

[ "$1" = "notebook" ] && {
	exec jupyter ${*}
	exit $?
}

exec "$@"
