import std / [sequtils, strutils, algorithm]

type
    Point = tuple[x: int, y: int, v: int8] 
    Map = seq[seq[int8]]
    Basin = seq[Point]

proc createMap(rows: seq[string]): Map = 
    result = newSeq[seq[int8]](rows.len)

    for y, row in rows:
        result[y] = newSeq[int8](row.len)
        for x, d in row:
            result[y][x] = (int8) parseInt($d)         # Creates a string, how to avoid this?

proc isAdjacent(basin: Basin, other: Basin): bool = 
    for a in basin:
        for b in other:
            if a.y == b.y and abs(a.x - b.x) == 1:
                return true
            if a.x == b.x and abs(a.y - b.y) == 1:
                return true

proc mergewith(basin: var Basin, other: Basin): void = 
    basin = basin.concat(other)

proc merge(basins: var seq[Basin], index: int): seq[Basin] = 
    if index == 0:
        return basins
    else:
        var
            selected = basins[index]
            i = index - 1

        while i > -1:
            if basins[i].isAdjacent(selected):
                basins[i].mergeWith(selected)
                basins.del(index)
                break
            dec i

        merge(basins, index - 1)

proc findBasins(map: Map): seq[Basin] =
    var
        basins: seq[Basin] = @[]
        current: Basin = @[]

    proc newRow(): void =
        if (current.len > 0):
            basins.add(current)
        current = @[]

    for y, row in map:
        for x, cell in row:
            if y == 0 and x == 0:
                current.add((x: x, y: y, v: map[y][x]))
            elif map[y][x] == 9:
                newRow()
            else:
                current.add((x: x, y: y, v: map[y][x]))
        newRow()

    merge(basins, basins.high)

if isMainModule:
    var
        data = readFile("2021/day09/input.txt").strip().split("\n").toSeq
        map = createMap(data)
        basins = map.findBasins()
        answer = 0
    
    var basinsSums = basins.mapIt(it.len)
    basinsSums.sort()
    basinsSums.reverse()

    answer = basinsSums[0 .. 2].foldl(a * b)
    echo "Answer: ", answer