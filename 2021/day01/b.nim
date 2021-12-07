import std/[sequtils, strutils, math]

var measurements = lines("2021/day01/input.txt")
    .toSeq
    .map(parseInt)

var
    answer = 0
    processed: seq[int] = @[measurements.len]
    previous = 0

for idx, depth in measurements:
    processed.add(depth)

    if idx > 1:
        var
            f = idx - 1
            t = idx + 1
            window = processed[f..t].sum

        if window > previous and previous > 0:
            inc answer
        previous = window

echo "Answer: ", answer