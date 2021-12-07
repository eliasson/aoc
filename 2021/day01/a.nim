import std/[sequtils, strutils]

var measurements = lines("2021/day01/input.txt")
    .toSeq
    .map(parseInt)

var
    answer = 0
    previous = 0

for depth in measurements:
    if depth > previous and previous > 0:
        inc answer
    previous = depth

echo "Answer: ", answer