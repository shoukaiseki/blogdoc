# awk使用外部變數

```Bash
#!/bin/bash -
ROWSTART=3
set -o nounset                              # Treat unset variables as an error
echo -ne "asus\nfedora\n"| awk '{printf  "row="'$ROWSTART'+NR" value="$1"\n" }'

```
