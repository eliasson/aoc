import std/[sequtils, strutils]

type
    Section = tuple[low: int, high: int]

proc overlap(one: Section, two: Section): bool =
    if one.low <= two.low and one.high >= two.high:
        result = true
    elif two.low <= one.low and two.high >= one.high:
        result = true

var
    data = lines("2022/day04/input").toSeq
    overlaps = 0

for setup in data:
    let pairs = setup.split(",")
    let one = pairs[0].split("-").map(parseInt)
    let two = pairs[1].split("-").map(parseInt)
    let low = (low: one[0], high: one[1])
    let high = (low: two[0], high: two[1])
    if overlap(low, high):
        overlaps += 1

echo "Answer: ", overlaps

# nim c -r 2022/day04/a.nim
