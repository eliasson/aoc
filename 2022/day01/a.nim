import std/[sequtils, strutils, algorithm]

var
    data = lines("2022/day01/input").toSeq
    elfs: seq[int] = @[]
    acc = 0

for food in data:
    if food == "":
        elfs.add(acc)
        acc = 0
    else:
        var calories = parseInt(food)
        acc += calories

elfs.sort(SortOrder.Descending)

echo "Answer: ", elfs[0]

# nim c -r 2022/day01/a.nim