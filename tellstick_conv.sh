#!/usr/bin/env bash
# Convert tellstick.conf format to JSON format accepted by hassio
#
# Author: Joakim Lindbom 2018-10-21
#

FILE='tellstick.conf'

sed -i '/#/d' $FILE

# Add comma sign at end of line
sed -i '/^  id = / s/$/,/g' $FILE
sed -i '/^  name = / s/$/,/g' $FILE
sed -i '/^  protocol = / s/$/,/g' $FILE
sed -i '/^  model = / s/$/,/g' $FILE
sed -i '/^    house = / s/$/,/g' $FILE

# Remove
sed -i 's/device {/{/g' $FILE
sed -i 's/id = /\"id\": /g' $FILE

#Add double quotes
sed -i 's/name = /\"name\": /g' $FILE
sed -i 's/  controller = 0//g' $FILE
sed -i 's/protocol = /\"protocol\": /g' $FILE
sed -i 's/model = /\"model\": /g' $FILE
sed -i 's/    house = /\  "house\": /g' $FILE
sed -i 's/    unit = /\  "unit\": /g' $FILE
sed -i 's/    code =/\  "code\": /g' $FILE

#Remove
sed -i 's/  parameters {//g' $FILE
sed -i 's/  }//g' $FILE

# Add comma sign
sed -i 's/}/},/g' $FILE
