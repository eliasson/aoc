import std/[sequtils, strutils]

var data = lines("2021/day02/input.txt").toSeq

type
    Submarine = object
        x: int
        y: int

var
    answer = 0
    sub = Submarine(x: 0, y: 0)

for row in data:
    var
        kv = row.split(" ")
        instruction = kv[0]
        units = parseInt(kv[1])

    case instruction
    of "forward":
        sub.x += units
    of "up":
        sub.y -= units
    of "down":
        sub.y += units
    else: continue

answer = sub.x * sub.y
echo "Answer: ", answer