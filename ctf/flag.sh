#!/bin/sh
# >>> isoloom-1.0 secret-from-file shim (auto-added by convert-lab.py) >>>
# Inputs now arrive as files (isoloom.yml `files:`), not environment variables.
# Read each into its old variable when unset, keeping the dev/CI fallback working.
for __p in CTF_FLAG_MAIN:/run/lab/ctf_flag_main CTF_FLAG_API6:/run/lab/ctf_flag_api6 CTF_FLAG_API7:/run/lab/ctf_flag_api7 CTF_FLAG_API10:/run/lab/ctf_flag_api10 CTF_FLAG_JUST_WEAK_TOKEN:/run/lab/ctf_flag_just_weak_token CTF_FLAG_STICKY_NOTES:/run/lab/ctf_flag_sticky_notes; do
  __n=${__p%%:*}; __f=${__p#*:}
  eval "__v=\${$__n:-}"
  if [ -z "$__v" ] && [ -s "$__f" ]; then
    __v=$(tr -d '\r\n' < "$__f"); eval "export $__n=\"\$__v\""
  fi
done
unset __p __n __f __v 2>/dev/null || true
# <<< isoloom-1.0 secret-from-file shim <<<
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
