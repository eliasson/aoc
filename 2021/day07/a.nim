import std/[sequtils, strutils, stats]

var numbers = readFile("2021/day07/input.txt")
    .strip()
    .split(",")
    .map(parseInt)

var positions: RunningStat
positions.push(numbers)

var
    min = (int) positions.min
    max = (int) positions.max
    answer = high(int)

# Brute force FTW
for target in min .. max:
    var run = 0
    for n in numbers:
        var diff = abs(target - n)
        run.inc(diff)
    if run < answer:
        answer = run

echo "Answer: ", answer
