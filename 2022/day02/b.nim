import std/[sequtils, strutils]

const
    Rock = "A"
    Paper = "B"
    Scissors = "C"
    LooseStrategy = "X"
    WinStrategy = "Z"

proc loose(hand: string): string =
    if hand == Rock:
        result = Scissors
    elif hand == Paper:
        result = Rock
    elif hand == Scissors:
        result = Paper

proc win(hand: string): string =
    if hand == Rock:
        result = Paper
    elif hand == Paper:
        result = Scissors
    elif hand == Scissors:
        result = Rock

proc selectHand(them: string, strategy: string): string =
    if strategy == LooseStrategy:
        result = loose(them)
    elif strategy == WinStrategy:
        result = win(them)
    else:
        result = them

proc score(them: string, you: string): int =
    if you == Rock:
        result += 1
    elif you == Paper:
        result += 2
    elif you == Scissors:
        result += 3

    if you == them:
        result += 3
    elif you == Paper and them == Rock:
        result += 6
    elif you == Rock and them == Scissors:
        result += 6
    elif you == Scissors and them == Paper:
        result += 6

var
    data = lines("2022/day02/input").toSeq
    totalScore = 0

for setup in data:
    let moves = setup.split(" ")
    let them = moves[0]
    let you = selectHand(them, moves[1])
    totalScore += score(them, you)

echo "Answer: ", totalScore

# nim c -r 2022/day02/b.nim