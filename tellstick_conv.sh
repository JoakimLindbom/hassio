#!/usr/bin/env bash
# Convert tellstick.conf format to JSON format accepted by hassio
#
# Author: Joakim Lindbom 2018-10-21
#

FILE='tellstick.conf'
FILEOUT='tellstick.json'

rm $FILEOUT 2>/dev/null

sed '/#/d' $FILE > $FILEOUT

# Add comma sign at end of line
sed -i '/^  id = / s/$/,/g' $FILEOUT
sed -i '/^  name = / s/$/,/g' $FILEOUT
sed -i '/^  protocol = / s/$/,/g' $FILEOUT
sed -i '/^  model = / s/$/,/g' $FILEOUT
sed -i '/^    house = / s/$/,/g' $FILEOUT

# Remove
sed -i 's/device {/{/g' $FILEOUT
sed -i 's/id = /\"id\": /g' $FILEOUT

#Add double quotes
sed -i 's/name = /\"name\": /g' $FILEOUT
sed -i 's/  controller = 0//g' $FILEOUT
sed -i 's/protocol = /\"protocol\": /g' $FILEOUT
sed -i 's/model = /\"model\": /g' $FILEOUT
sed -i 's/    house = /\  "house\": /g' $FILEOUT
sed -i 's/    unit = /\  "unit\": /g' $FILEOUT
sed -i 's/    code =/\  "code\": /g' $FILEOUT

#Remove
sed -i 's/  parameters {//g' $FILEOUT
sed -i 's/  }//g' $FILEOUT

# Add comma sign
sed -i 's/}/},/g' $FILEOUT

#Remove the controller section at the end
sed -i '/controller {/,$d' $FILEOUT

#tac $FILEOUT | awk '/},/ && ! seen {print "}"; seen=1} {print}' | tac
sed -zE 's_(.*)},_\1}_' $FILEOUT >tempfile
mv tempfile $FILEOUT
#sed 's/\(.*\)},\(.*\)/\1\2/' $FILEOUT

sed -i '/^$/d' $FILEOUT
