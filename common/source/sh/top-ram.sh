#!/bin/sh
notify-send 'RAM Usage Top' "$(ps achx -o %mem,cmd --sort -%mem | head -n4 | sed 's/\([[:digit:]]\) /\1% /')"
