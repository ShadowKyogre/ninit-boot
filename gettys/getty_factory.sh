#!/bin/sh
# Usage: getty_factory.sh getty {1..3}

cmd="${1}"
getty_dir="$(realpath $(dirname $0))"
shift

cp /dev/null "${getty_dir}/depends"

for TTY in "$@" ; do
  echo -n "Creating service for TTY $1 using $cmd..."
  echo "gettys/${TTY}" >> "${getty_dir}/depends"
  test -d "${getty_dir}/$TTY" || mkdir "${getty_dir}/$TTY"
  sed "s/\${TTY}/${TTY}/" "${getty_dir}/params.tpl" > "${getty_dir}/${TTY}/params"
  if [[ "$cmd" == */* ]]
  then
    ln -sf "$cmd" "${getty_dir}/${TTY}/run"
  else
    ln -sf "$(which $cmd)" "${getty_dir}/${TTY}/run"
  fi
  ln -sf "${getty_dir}/environ.tpl" "${getty_dir}/${TTY}/environ"
  touch "${getty_dir}/${TTY}/respawn"
  echo "Done!"
  shift
done
