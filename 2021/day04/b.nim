import std/[sequtils, strutils]

var data = readFile("2021/day04/input.txt").split("\n\n").toSeq

type
    Row = seq[int]

    Board = ref object
        rows: seq[Row]
        points: int

proc initBoard(layout: string): Board =
    var rows: seq[Row] = @[]

    for row in layout.split("\n"):
        var numbers = row.splitWhitespace().map(parseInt)
        var row = Row(numbers)
        rows.add(row)
    return Board(rows: rows)

proc play(board: Board, number: int): bool =
    if board.points > 0:
        return false

    for rowIndex, row in board.rows:
        for cellIdx, cell in row:
            if cell == number:
                board.rows[rowIndex][cellIdx] = -1 # Match by replacing value with -1
                var hasBingo =
                    allIt(row, it == -1) or
                    allIt(board.rows, it[cellIdx] == -1)

                if hasBingo:
                    var sum = 0
                    for r in board.rows:
                        for c in r:
                            if c > 0:
                                sum += c
                    if sum * number > 0:
                        board.points = sum * number
    return true

var
    numbers: seq[int] = @[]
    boards: seq[Board] = @[]
    bingos: seq[int] = @[]

# Build game boards
for idx, row in data:
    if idx == 0:
        for digitAsString in row.split(","):
            numbers.add(parseInt(digitAsString))
    else:
        boards.add(initBoard(row))

# Play
for number in numbers:
    for board in boards:
        if board.play(number) and board.points > 0:
            bingos.add(board.points)

echo "Answer: ", bingos[^1]
