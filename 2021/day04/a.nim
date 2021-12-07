import std/[sequtils,strutils]

var data = readFile("2021/day04/input.txt")
    .split("\n\n")
    .toSeq

type
    Row = seq[int]

    Board = ref object  # Heap allocated
        rows: seq[Row]

proc newBoard(layout: string): Board =
    var rows: seq[Row] = @[]
    for row in layout.split("\n"):
        var
            numbers = row.splitWhitespace().map(parseInt)
            row = Row(numbers)
        rows.add(row)
    return Board(rows: rows)

proc play(board: Board, number: int): void =
    for rowIndex, row in board.rows:
        for cellIdx, cell in row:
            if cell == number:
                board.rows[rowIndex][cellIdx] = -1 # Match by replacing value with -1
                var hasBingo =
                    allIt(row, it == -1) or
                    allIt(board.rows, it[cellIdx] == -1)

                if hasBingo:
                    var
                        sum = 0
                        answer = 0
                    for r in board.rows:
                        for c in r:
                            if c > 0:
                                sum += c
                    answer = sum * number
                    raise newException(ValueError, $answer) # Like a pro

var
    numbers: seq[int] = @[]
    boards: seq[Board] = @[]

# Build game boards
for idx, row in data:
    if idx == 0:
        for digitAsString in row.split(","):
            numbers.add(parseInt(digitAsString))
    else:
        boards.add(newBoard(row))

try:
    for number in numbers:
        for board in boards:
            board.play(number)
except ValueError as e:
    echo "Answer: ", e.msg
