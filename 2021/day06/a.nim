import std/[sequtils, strutils, strformat]

var data = readFile("2021/day06/input.txt")

var
    answer = 0
    lanterns = data.split(",").map(parseInt)

for day in 0 ..< 80:
    # Iterate from back to be able to add to tail
    var index = lanterns.high
    while index > -1:
        if lanterns[index] == 0:
            lanterns[index] = 6
            lanterns.add(8)
        else:
            dec lanterns[index]
        dec index

answer = lanterns.len
echo "Answer: ", answer