import std / [sequtils, strutils, tables, math]

proc match(a, b: char): bool =
    if a == ')' and b == '(':
        return true
    elif a == ']' and b == '[':
        return true
    elif a == '}' and b == '{':
        return true
    elif a == '>' and b == '<':
        return true

if isMainModule:
    var
        data = readFile("2021/day10/input.txt").strip().split("\n").toSeq
        illegals: seq[char] = @[]
        points: Table[char, int] = {')': 3, ']': 57, '}': 1197, '>': 25137}.toTable

    for row in data:
        var stack: seq[char] = @[]
        for idx, c in row:
            if idx > 0 and match(c, stack[^1]):
                discard stack.pop()
            elif c in [')', ']','}','>']:
                illegals.add(c)
                break
            else:
                stack.add(c)
        stack = @[]

    echo "Answer: ", sum(illegals.mapIt(points[it]))