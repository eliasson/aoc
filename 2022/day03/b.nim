import std/[sequtils, tables]

proc buildScoreTable(): Table[char, int] =
    result = initTable[char, int]()
    for i, c in "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ":
        result[c] = i + 1

proc unique(values: seq[string]): char =
    var seen: CountTable[char] = initCountTable[char]()
    for v in values:
        var rucksackContent = v[0..^1].deduplicate()
        for c in rucksackContent:
            seen.inc(c)
    result = seen.largest[0]

iterator take(data: seq[string], quantity: int): seq[string] =
    var index = 0
    var q = quantity - 1
    while (index + q) < data.len:
        yield data[index..(index + q)]
        index += quantity

var
    data = lines("2022/day03/input").toSeq
    score = buildScoreTable()
    total = 0

for grp in data.take(3):
    let mgn = unique(grp) 
    total += score[mgn]

echo "Answer: ", total

# nim c -r 2022/day03/b.nim
