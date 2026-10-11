#!/bin/sh
# Places the player's flags for API1, API2, API3, API4, API5, API8 and API9 (CTF_FLAG_API<N>,
# given by the launcher) in the rows of the vapi database where upstream keeps its own flags;
# without them (CI, a run by hand) the development flags. Runs on the db machine at every start.
# val <value> <key>: the value, else the development flag, quoted for a MySQL string literal.
val() {
  v=$1; dev="FLAG{dev-vapi-$2}"
  [ -n "$v" ] || v=$dev
  printf '%s' "$v" | sed "s/'/''/g; s/\\\\/\\\\\\\\/g"
}
f1=$(val "$CTF_FLAG_API1" api1)
f2=$(val "$CTF_FLAG_API2" api2)
f3=$(val "$CTF_FLAG_API3" api3)
f4=$(val "$CTF_FLAG_API4" api4)
f5=$(val "$CTF_FLAG_API5" api5)
f8=$(val "$CTF_FLAG_API8" api8)
f9=$(val "$CTF_FLAG_API9" api9)
until mysql -h 127.0.0.1 -uroot -pvapi123456 -e 'select 1 from a_p_i9_users limit 1' vapi >/dev/null 2>&1; do sleep 2; done
mysql -h 127.0.0.1 -uroot -pvapi123456 vapi <<SQL
UPDATE a_p_i1_users SET course = '$f1' WHERE id = 1;
UPDATE a_p_i2_users SET address = '$f2' WHERE id = 2;
UPDATE a_p_i3_comments SET deviceid = '$f3' WHERE id = 1;
UPDATE a_p_i4_users SET lastname = '$f4' WHERE id = 1;
UPDATE a_p_i5_users SET address = '$f5' WHERE id = 1;
UPDATE a_p_i8_users SET secret = '$f8' WHERE id = 1;
UPDATE a_p_i9_users SET accbalance = '$f9' WHERE id = 1;
SQL
