import std/[sequtils, parseutils]

var data = lines("2021/day03/input.txt").toSeq

func rate(input: seq[string], favourOne: bool): int =
    var
        index = 0
        qualified = input.toSeq

    while qualified.len > 1:
        var
            frequency0 = 0
            frequency1 = 0
            mostCommon = if favourOne: 1 else: 0

        for row in qualified:
            if row[index] == '0':
                frequency0 += 1
            else:
                frequency1 += 1

        if frequency1 > frequency0:
            mostCommon = if favourOne: 1 else: 0
        elif frequency0 > frequency1:
            mostCommon = if favourOne: 0 else: 1

        qualified = qualified.filterIt($it[index] == $mostCommon)
        inc index

    discard parseBin(qualified[0], result)

var
    oxygen = rate(data, true)
    co2 = rate(data, false)
    answer = oxygen * co2

echo "Answer: ", answer