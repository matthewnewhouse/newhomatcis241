#!/usr/bin/env bash

sed -n '50,$p' lyrics |sed '1!G;h;$!d' > ending_lyrics
