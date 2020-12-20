#./generate_seat_list.sh > seats.txt

FILE=seats.txt
TARGET=exam_template.tex
OUTPUT=paper.pdf
while read -r line;
do
    echo $line
    # Linux
    #cp $TARGET ${TARGET}.bak
    #sed -i 's/SEAT/"$line"/' exam_template.tex
    # macOS
    SUBS="s/SEAT/$line/"
    sed -i.bak $SUBS exam_template.tex
    make pdf > /dev/null 2>&1
    mv ${OUTPUT} ${line}_${OUTPUT}
    cp $TARGET.bak ${TARGET}
done < seats.txt
