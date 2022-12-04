import std/[sequtils, tables]

proc buildScoreTable(): Table[char, int] =
    result = initTable[char, int]()
    for i, c in "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ":
        result[c] = i + 1

proc overlap(low: string, high: string): seq[char] =
    result = @[]
    for c in low:
        if c in high and c notin result:
            result.add(c)

var
    data = lines("2022/day03/input").toSeq
    score = buildScoreTable()
    total = 0

for content in data:
    let middle = (int) (content.len / 2)
    let low = content[0..middle - 1]
    let high = content[middle..^1]

    let overlapping = overlap(low, high)
    for c in overlapping:
        total += score[c]

echo "Answer: ", total

# nim c -r 2022/day03/a.nim
