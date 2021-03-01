#!/usr/bin/env bash

sed -E 's/<\/script>/<\/script>\n/g' faculty | sed -E '/<script.*>/,/<\/script>/d' > faculty.index

