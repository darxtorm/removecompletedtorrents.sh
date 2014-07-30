#!/bin/sh
TORRENTLIST=`transmission-remote --auth=user:password --list | sed -e '1d;$d;s/^ *//' | cut --only-delimited --delimiter=' ' --fields=1`

for TORRENTID in $TORRENTLIST
do
echo "* * * * * Operations on torrent ID $TORRENTID starting. * * * * *"

DL_COMPLETED=`transmission-remote --auth=user:password --torrent $TORRENTID --info | grep "Percent Done: 100%"`
if [ "$DL_COMPLETED" != "" ]; then
echo "Torrent #$TORRENTID is completed."
echo "Removing torrent from list."
transmission-remote --auth=user:password --torrent $TORRENTID --remove
else
echo "Torrent #$TORRENTID is not completed. Ignoring."
fi
echo "* * * * * Operations on torrent ID $TORRENTID completed. * * * * *"
done