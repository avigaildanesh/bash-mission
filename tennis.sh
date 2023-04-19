
player1_points=50
player2_points=50
place="normal"
counter=0
flag=0

# draw
function normal() {
    echo " --------------------------------- "
    echo " |       |       #       |       | "
    echo " |       |       #       |       | "
    echo " |       |       O       |       | "
    echo " |       |       #       |       | "
    echo " |       |       #       |       | "
    echo " --------------------------------- "
}

function left() {
    echo " --------------------------------- "
    echo " |       |       #       |       | "
    echo " |       |       #       |       | "
    echo " |       |   O   #       |       | "
    echo " |       |       #       |       | "
    echo " |       |       #       |       | "
    echo " --------------------------------- "
    place="left"
}

function twoleft() {
    echo " --------------------------------- "
    echo " |       |       #       |       | "
    echo " |       |       #       |       | "
    echo " |   O   |       #       |       | "
    echo " |       |       #       |       | "
    echo " |       |       #       |       | "
    echo " --------------------------------- "
    place="twoleft"
}


function outleft() {
    echo " --------------------------------- "
    echo " |       |       #       |       | "
    echo " |       |       #       |       | "
    echo "0|       |       #       |       | "
    echo " |       |       #       |       | "
    echo " |       |       #       |       | "
    echo " --------------------------------- "
    place="outleft"
}


function right() {
    echo " --------------------------------- "
    echo " |       |       #       |       | "
    echo " |       |       #       |       | "
    echo " |       |       #   O   |       | "
    echo " |       |       #       |       | "
    echo " |       |       #       |       | "
    echo " --------------------------------- "
    place="right"
}

function tworight() {
    echo " --------------------------------- "
    echo " |       |       #       |       | "
    echo " |       |       #       |       | "
    echo " |       |       #       |   O   | "
    echo " |       |       #       |       | "
    echo " |       |       #       |       | "
    echo " --------------------------------- "
    place="tworight"
}


function outright() {
    echo " --------------------------------- "
    echo " |       |       #       |       | "
    echo " |       |       #       |       | "
    echo " |       |       #       |       |O"
    echo " |       |       #       |       | "
    echo " |       |       #       |       | "
    echo " --------------------------------- "
    place="outright"
}

function player1lost() {
    echo -e "       Player 1 played: ${ans1}\n       Player 2 played: ${ans2}\n\n"
    echo "PLAYER 2 WINS !"
    exit 1
}
function player2lost() {
    echo -e "       Player 1 played: ${ans1}\n       Player 2 played: ${ans2}\n\n"
    echo "PLAYER 1 WINS !"
    exit 1
}

function draw() {
    echo -e "       Player 1 played: ${ans1}\n       Player 2 played: ${ans2}\n\n"
    echo "IT'S A DRAW !"
    exit 1
}


function oneltwo() {
    #go left
    if [ "$ans1" -lt "$ans2" ]; then
        if [ "$place" = "normal" ]; then
            left
        elif [ "$place" = "left" ]; then
            twoleft
        elif [ "$place" = "twoleft" ]; then
            outleft
            player1lost
        elif [ "$place" = "right" ]; then
            left
        elif [ "$place" = "tworight" ]; then
            left
        elif [ "$place" = "outright" ]; then
            outright
            player2lost
        elif [ "$place" = "outleft" ]; then
            outleft
            player1lost
        fi
    fi
    # go right
    if [ "$ans1" -gt "$ans2" ]; then
        if [ "$place" = "normal" ]; then
            right
        elif [ "$place" = "left" ]; then
            right
        elif  [ "$place" = "right" ]; then
            tworight
        elif [ "$place" = "twoleft" ]; then
            right
        elif [ "$place" = "tworight" ]; then
            outright
            player2lost
        elif [ "$place" = "outright" ]; then
            outright
            player2lost
        elif [ "$place" = "outleft" ]; then
            outleft
            player1lost
        fi
    fi
}

while true; do
    if [ $counter -eq 0 ]; then
    echo " Player 1: ${player1_points}         Player 2: ${player2_points} "
    normal
    fi

    echo "PLAYER 1 PICK A NUMBER: "
    read -s ans1
    #if not a number
    while ! [[ $ans1 =~ ^[0-9]+$ ]]; do
        echo "NOT A VALID MOVE!"
        echo "PLAYER 1 PICK A NUMBER: "
        read -s ans1
    done        

    echo "PLAYER 2 PICK A NUMBER: "
    read -s ans2
    #if not a number
    while ! [[ $ans2 =~ ^[0-9]+$ ]]; do
        echo "NOT A VALID MOVE!"
        echo "PLAYER 2 PICK A NUMBER: "
        read -s ans2
    done  

    ans1=$((ans1))
    ans2=$((ans2))
    player1_points=$((player1_points - ans1))
    player2_points=$((player2_points - ans2))
    echo " Player 1: ${player1_points}         Player 2: ${player2_points} "

    #check if someone lost
    if [ "$place" = "outleft" ]; then
        outleft
        player1lost
        break
    fi
    if [ "$place" = "outright" ]; then
        outright
        player2lost
        break
    fi
    
    # 2 win, move left
    if [ $player1_points -le 0 ] && [ $player2_points -gt 0 ]; then
        oneltwo
        player1lost
        break
    fi
    if [ $player2_points -le 0 ] && [ $player1_points -gt 0 ]; then
        oneltwo
        player2lost  
        break
    fi

    if [ $player2_points -eq 0 ] && [ $player1_points -eq 0 ]; then
        if [ $ans1 -gt $ans2 ]; then
            outright
            player2lost
        fi
        if [ $ans1 -lt $ans2 ]; then
            outleft
            player1lost
        fi

        if [ "$place" = "left" ]; then
            left
            player1lost

            break
        elif [ "$place" = "twoleft" ]; then
            twoleft
            player1lost
            break
        elif [ "$place" = "right" ]; then
            right
            player2lost
            break
        elif [ "$place" = "tworight" ]; then
            tworight
            player2lost
            break
        else
            normal
            draw
        fi
    fi

    if [ "$ans1" = "$ans2" ]; then
        if [ "$place" = "outleft" ]; then
            outleft
        fi
        if [ "$place" = "twoleft" ]; then
            twoleft
        fi
        if [ "$place" = "left" ]; then
            left
        fi
        if [ "$place" = "normal" ]; then
            normal
        fi
        if [ "$place" = "right" ]; then
            right
        fi
        if [ "$place" = "tworight" ]; then
            tworight
        fi
        if [ "$place" = "outright" ]; then
            outright
        fi
    fi
    oneltwo
    echo -e "       Player 1 played: ${ans1}\n       Player 2 played: ${ans2}\n\n"
    counter=1;
done

