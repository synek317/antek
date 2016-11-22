#!/bin/bash

for f in `find raw_assets -name '*.pack' | xargs dirname | cut -d '/' -f 2`; do
  echo "Updating $f"
  sed -E s/\\r//g "raw_assets/$f/$f.pack" > "assets/data/atlases/$f.pack"
  cp "raw_assets/$f/$f.png"  "assets/images/"
done

DECORATIONS_PACK=assets/data/atlases/decorations.pack

if [ -f $DECORATIONS_PACK ]; then
	echo "Adjusting $DECORATIONS_PACK (bush_rabbit)"
	frame1=`sed -n '/bush_rabbit\/01/,/index: -1/p' $DECORATIONS_PACK`
	frame2=`sed -n '/bush_rabbit\/02/,/index: -1/p' $DECORATIONS_PACK`
	frame3=`sed -n '/bush_rabbit\/03/,/index: -1/p' $DECORATIONS_PACK`
	frame4=`sed -n '/bush_rabbit\/04/,/index: -1/p' $DECORATIONS_PACK`
	frame5=`echo -e "$frame4" | sed 's/bush_rabbit\/04/bush_rabbit\/05/'`
	frame6=`echo -e "$frame4" | sed 's/bush_rabbit\/04/bush_rabbit\/06/'`
	frame7=`echo -e "$frame4" | sed 's/bush_rabbit\/04/bush_rabbit\/07/'`
	frame8=`echo -e "$frame2" | sed 's/bush_rabbit\/02/bush_rabbit\/08/'`
	frame9=`echo -e "$frame1" | sed 's/bush_rabbit\/01/bush_rabbit\/09/'`
	frame4_line=`grep -n bush_rabbit/04 $DECORATIONS_PACK | cut -d ':' -f 1`
	target_line=$((frame4_line+6))
	head -n $target_line $DECORATIONS_PACK > ${DECORATIONS_PACK}.tmp
	echo "$frame5" >> ${DECORATIONS_PACK}.tmp
	echo "$frame6" >> ${DECORATIONS_PACK}.tmp
	echo "$frame7" >> ${DECORATIONS_PACK}.tmp
	echo "$frame8" >> ${DECORATIONS_PACK}.tmp
	echo "$frame9" >> ${DECORATIONS_PACK}.tmp
	tail -n +$((target_line+1)) $DECORATIONS_PACK >> ${DECORATIONS_PACK}.tmp
	rm $DECORATIONS_PACK
	mv ${DECORATIONS_PACK}.tmp $DECORATIONS_PACK

	echo "Adjusting $DECORATIONS_PACK (bird)"
	frame2=`sed -n '/bird\/02/,/index: -1/p' $DECORATIONS_PACK`
	frame4=`echo -e "$frame2" | sed 's/bird\/02/bird\/04/'`
	frame3_line=`grep -n bird/03 $DECORATIONS_PACK | cut -d ':' -f 1`
	target_line=$((frame3_line+6))
	head -n $target_line $DECORATIONS_PACK > ${DECORATIONS_PACK}.tmp
	echo "$frame4" >> ${DECORATIONS_PACK}.tmp
	tail -n +$((target_line+1)) $DECORATIONS_PACK >> ${DECORATIONS_PACK}.tmp
	rm $DECORATIONS_PACK
	mv ${DECORATIONS_PACK}.tmp $DECORATIONS_PACK
else
  echo "Warning: could not find file $DECORATIONS_PACK"
fi

echo "End."