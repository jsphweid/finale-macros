#!/bin/bash

if [ -z "${FINALEMACROS_DIR}" ]; then
	FINALEMACROSZIPFILE="$HOME/.finale-macros"
fi

FINALEMACROSZIPFILE="${FINALEMACROS_DIR}/installArchive.zip"

echo "creating directory in home folder..."
mkdir -p "${FINALEMACROS_DIR}"
cd "${FINALEMACROS_DIR}"

echo "downloading current .zip of .finale-macros from Github..."
curl -LOk "https://github.com/jsphweid/.finale-macros/archive/master.zip" > "${FINALEMACROSZIPFILE}"

echo "unzipping archive..."
unzip -qo "${FINALEMACROSZIPFILE}" -d "${FINALEMACROS_DIR}"

echo "end"