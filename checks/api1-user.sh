#!/bin/sh
# API1 answers a user record from the seeded database for a valid Authorization-Token
# (base64 of username:password of a seeded user, meredithp).
curl -fsS -H 'Authorization-Token: bWVyZWRpdGhwOltOYVo3UlVNYksjTw==' http://www/vapi/api1/user/2 | grep -q '"username":"meredithp"'
