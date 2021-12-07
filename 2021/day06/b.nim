import std/[sequtils, strutils, tables]

var data = readFile("2021/day06/input.txt")

var
    answer = 0
    lanterns = initTable[int, int]()

for seed in data.split(",").map(parseInt):
    if lanterns.hasKey(seed):
        inc lanterns[seed]
    else:
        lanterns[seed] = 1

for day in 0 ..< 256:
    var newborn = 0

    for key in 0 .. 8:
        if not lanterns.hasKey(key):
            lanterns[key] = 0
        if key == 0:
            newborn = lanterns[key]
            lanterns[0] = 0
        else:
            lanterns[key - 1] = lanterns[key]
            lanterns[key] = 0

    lanterns[6] = lanterns[6] + newborn
    lanterns[8] = newborn

for count in lanterns.values:
    answer += count
echo "Answer: ", answer