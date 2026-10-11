#!/bin/sh
# Keeps the player's flags for the www machine (given by the launcher) in the ctf volume, where
# ctf-entrypoint.sh finds them on a restart; without them (CI, a run by hand) the development
# flags. The entrypoint writes /flag.txt and Variables.php from them.
put() { # put <value> <key>
  v=$1; dev="FLAG{dev-vapi-$2}"
  [ -n "$v" ] || v=$dev
  printf '%s\n' "$v" > "/ctf/$2"
  chmod 400 "/ctf/$2"
}
put "$CTF_FLAG_MAIN" main
put "$CTF_FLAG_API6" api6
put "$CTF_FLAG_API7" api7
put "$CTF_FLAG_API10" api10
put "$CTF_FLAG_JUST_WEAK_TOKEN" just-weak-token
put "$CTF_FLAG_STICKY_NOTES" sticky-notes
