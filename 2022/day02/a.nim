import std/[sequtils, strutils]

const
    ThemRock = "A"
    ThemPaper = "B"
    ThemScissors = "C"
    YouRock = "X"
    YouPaper = "Y"
    YouScissors = "Z"

proc score(them: string, you: string): int =
    if you == YouRock:
        result += 1
    elif you == YouPaper:
        result += 2
    elif you == YouScissors:
        result += 3

    if (you == YouRock and them == ThemRock) or 
       (you == YouPaper and them == ThemPaper) or
       (you == YouScissors and them == ThemScissors):
        result += 3
    elif you == YouPaper and them == ThemRock:
        result += 6
    elif you == YouRock and them == ThemScissors:
        result += 6
    elif you == YouScissors and them == ThemPaper:
        result += 6

var
    data = lines("2022/day02/input").toSeq
    totalScore = 0

for setup in data:
    let moves = setup.split(" ")
    totalScore += score(moves[0], moves[1])

echo "Answer: ", totalScore

# nim c -r 2022/day02/a.nim