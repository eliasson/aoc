import std / [sequtils, strutils]

type
    Point = tuple[x: int, y: int]
    Map = seq[seq[int8]]

func createMap(rows: seq[string]): Map = 
    result = newSeq[seq[int8]](rows.len)

    for y, row in rows:
        result[y] = newSeq[int8](row.len)
        for x, d in row:
            result[y][x] = (int8) parseInt($d)

func isLowerThanAdjacentCells(point: Point, map: Map): bool = 
    var
        pointValue = map[point.y][point.x]
        lowerThan = 0

    if point.y > 0 and map[point.y - 1][point.x] > pointValue:
        inc lowerThan
    if point.x > 0 and map[point.y][point.x - 1] > pointValue:
        inc lowerThan
    if point.y < map.high and map[point.y + 1][point.x] > pointValue:
        inc lowerThan
    if point.x < map[0].high and map[point.y][point.x + 1] > pointValue:
        inc lowerThan
    
    if point.y == 0:
        inc lowerThan
    if point.y == map.high:
        inc lowerThan
    if point.x == 0:
        inc lowerThan
    if point.x == map[0].high:
        inc lowerThan

    return lowerThan == 4

func findLowPoints(map: Map): seq[int8] =
    for y, row in map:
        for x, cell in row:
            if isLowerThanAdjacentCells((x: x, y: y), map):
                result.add(map[y][x] + 1)

if isMainModule:
    var
        data = readFile("2021/day09/input.txt").strip().split("\n").toSeq
        map = createMap(data)
        lows = map.findLowPoints()
        answer: int = 0

    for l in lows:      # Cannot use sum since it will overflow due to int8
        answer.inc(l)

    echo "Answer: ", answer