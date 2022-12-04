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

var
    data = lines("2022/day03/input").toSeq
    score = buildScoreTable()
    total = 0

iterator groups(): seq[string] =
    var index = 0

    while (index + 2) < data.len:
        yield data[index..(index+2)]
        index += 3

for grp in groups():
    let mgn = unique(grp) 
    total += score[mgn]

echo "Answer: ", total

# nim c -r 2022/day03/b.nim
