#!/bin/sh -x

set -e

echo "foo" > foo
if test $? != 0; then
	echo "ERROR: Failed to create file foo"
	exit 1
fi

chmod 400 foo
if test $? != 0; then
	echo "ERROR: Failed to change mode of foo"
	exit 1
fi

set +e
echo "bar" >> foo
if test $? = 0; then
	echo "ERROR: Write to read-only file should Fail"
	exit 1
fi

set -e
chmod 600 foo
echo "bar" >> foo
if test $? != 0; then
	echo "ERROR: Write to writeable file failed"
	exit 1
fi
