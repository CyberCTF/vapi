#!/bin/sh
# CyberCTF per-player flags, added by the overlay (the vendored source is unchanged).
# At every start each flag comes from its variable (given by the launcher), else the file
# ctf/flag.sh wrote in /ctf on an earlier start, else the development flag. The ServerSurfer
# flag goes to /flag.txt; the flags upstream keeps base64-encoded in Variables.php are swapped
# into a fresh copy of that file. Then vAPI starts exactly as before.
pick() { # pick <value> <key>
  if [ -n "$1" ]; then printf '%s' "$1"
  elif [ -s "/ctf/$2" ]; then head -n 1 "/ctf/$2" | tr -d '\n'
  else printf 'FLAG{dev-vapi-%s}' "$2"; fi
}
b64() { printf '%s' "$1" | base64 | tr -d '\n'; }
printf '%s\n' "$(pick "${CTF_FLAG_MAIN:-}" main)" > /flag.txt
chmod 444 /flag.txt
# The upstream values (base64) of getAPI6Flag, getAPI7Flag, getAPI10Flag, getJWTFlag, getXSSFlag.
sed -e "s|ZmxhZ3thcGk2X2FmYjk2OWRiOGI2ZTI3MjY5NGI0fQ==|$(b64 "$(pick "${CTF_FLAG_API6:-}" api6)")|" \
    -e "s|ZmxhZ3thcGk3X2U3MWI2NTA3MTY0NWUyNGVkNTBhfQ==|$(b64 "$(pick "${CTF_FLAG_API7:-}" api7)")|" \
    -e "s|ZmxhZ3thcGkxMF81ZGI2MTFmN2MxZmZkNzQ3OTcxZn0=|$(b64 "$(pick "${CTF_FLAG_API10:-}" api10)")|" \
    -e "s|ZmxhZ3tqd3RfcW5vcGtrdDNvd3N4bmRrMDgzdjF9|$(b64 "$(pick "${CTF_FLAG_JUST_WEAK_TOKEN:-}" just-weak-token)")|" \
    -e "s|ZmxhZ3t4c3NfZTJyZ2h4ZTQxNjRjYzI0NzJ4d2J9|$(b64 "$(pick "${CTF_FLAG_STICKY_NOTES:-}" sticky-notes)")|" \
    /usr/local/share/ctf/Variables.php > /var/www/html/vapi/app/CustomClasses/Variables.php
unset CTF_FLAG_MAIN CTF_FLAG_API6 CTF_FLAG_API7 CTF_FLAG_API10 CTF_FLAG_JUST_WEAK_TOKEN CTF_FLAG_STICKY_NOTES
exec "$@"
