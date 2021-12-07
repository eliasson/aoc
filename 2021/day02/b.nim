import std/[sequtils, strutils]

var data = lines("2021/day02/input.txt").toSeq

type
    Submarine = object
        x: int
        y: int
        aim: int

proc forward(sub: var Submarine, units: int) =
    sub.x += units
    sub.y += sub.aim * units

proc up(sub: var Submarine, units: int) =
    sub.aim -= units

proc down(sub: var Submarine, units: int) =
    sub.aim += units

var
    answer = 0
    sub = Submarine(x: 0, y: 0, aim: 0)

for row in data:
    var
        kv = row.split(" ")
        instruction = kv[0]
        units = parseInt(kv[1])

    case instruction
    of "forward":
        sub.forward(units)
    of "up":
        sub.up(units)
    of "down":
        sub.down(units)
    else: continue

answer = sub.x * sub.y
echo "Answer: ", answer