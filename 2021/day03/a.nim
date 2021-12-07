import std/[sequtils, parseutils]

var data = lines("2021/day03/input.txt").toSeq

func rate(input: seq[string], favourOne: bool): int =
    var
        resultBinString = ""
        width = input[0].len

    for index in 0 ..< width:
        var
            frequency0 = 0
            frequency1 = 0

        for row in input:
            if row[index] == '0':
                inc frequency0
            else:
                inc frequency1

        if frequency0 > frequency1:
            resultBinString.add(if favourOne: "0" else: "1")
        else:
            resultBinString.add(if favourOne: "1" else: "0")

    discard parseBin(resultBinString, result)

var
    gamma = rate(data, true)
    epsilon = rate(data, false)
    answer = gamma * epsilon

echo "Answer: ", answer