import std/[sequtils, strutils]

var data = readFile("2021/day05/input.txt")
    .split("\n")
    .toSeq

type
    Pos = object
        x: int
        y: int
    Line = object
        a: Pos
        b: Pos
    Row = ref object
        cells: seq[int]
    Grid = ref object
        rows: seq[Row]

proc initPos(pos: seq[int]): Pos =
    Pos(x: pos[0], y: pos[1])

proc positions(line: Line): seq[Pos] =
    result = @[]

    var
        pos = Pos(x: line.a.x, y: line.b.y)
        target = Pos(x: line.b.x, y: line.b.y)

    result.add(pos)

    while pos != target:
        if target.x > pos.x:
            inc pos.x
        elif target.x < pos.x:
            dec pos.x
        if target.y > pos.y:
            inc pos.y
        elif target.y < pos.y:
            dec pos.y
        result.add(pos)

proc markOnGrid(line: Line, grid: Grid): void =
    for pos in line.positions:
        var value = grid.rows[pos.y].cells[pos.x] + 1
        grid.rows[pos.y].cells[pos.x] = value

proc countMinIntersections(grid: Grid): int =
    for row in grid.rows:
        for cell in row.cells:
            if cell > 1:
                inc result

proc generateGrid(lines: seq[Line]): Grid =
    var
        maxX = 0
        maxY = 0
        rows: seq[Row] = @[]

    for line in lines:
        if line.a.x > maxX:
            maxX = line.a.x
        if line.b.x > maxX:
            maxX = line.b.x
        if line.a.y > maxY:
            maxY = line.a.y
        if line.b.y > maxY:
            maxY = line.b.y

    for y in 0..maxY:
        var row = Row()
        row.cells = @[]
        for x in 0..maxX:
            row.cells.add(0)
        rows.add(row)
    Grid(rows: rows)

proc generateLines(data: seq[string]): seq[Line] =
    var lines: seq[Line] = @[]
    for row in data:
        var 
            kv = row.split("->")
            pos1 = initPos(kv[0].strip().split(",").map(parseInt))
            pos2 = initPos(kv[1].strip().split(",").map(parseInt))
            line = Line(a: pos1, b: pos2)
        lines.add(line)
    lines

var
    answer = 0
    lines = generateLines(data)
    grid = generateGrid(lines)

for line in lines:
    line.markOnGrid(grid)

answer = grid.countMinIntersections()

echo "Answer: ", answer
