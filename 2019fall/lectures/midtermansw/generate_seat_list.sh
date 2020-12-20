ROW=(A B C D E F G H)
LEN=(14 16 20 22 24 24 22 20)
for (( i = 0 ; i < ${#ROW[@]} ; i++ ))
do
    for (( j = 1 ; j <= "${LEN[i]}" ; j++ ))
    do
        echo ${ROW[i]}$j
    done
done

ROW=(A B C D E F G H)
START=(102 101 101 101 101 101 101 102)
END=(109 112 112 112 112 112 112 109)
for (( i = 0 ; i < ${#ROW[@]} ; i++ ))
do
    for (( j = ${START[i]} ; j <= ${END[i]} ; j++ ))
    do
        echo ${ROW[i]}$j
    done
done
