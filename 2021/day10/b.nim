import std / [sequtils, strutils, tables, algorithm]

proc match(a, b: char): bool =
    if a == ')' and b == '(':
        return true
    elif a == ']' and b == '[':
        return true
    elif a == '}' and b == '{':
        return true
    elif a == '>' and b == '<':
        return true

proc incompleteLines(data: seq[string]): seq[string] =
    result = @[]
    var stack: seq[char] = @[]
    for row in data:
        var isIllegal = false
        for idx, c in row:
            if stack.len > 0 and match(c, stack[^1]):
                discard stack.pop()
            elif c in [')', ']','}','>']:
                isIllegal = true
                break
            else:
                stack.add(c)

        if not isIllegal:
            result.add(row)

        stack = @[]


if isMainModule:
    var
        data = readFile("2021/day10/input.txt").strip().split("\n").toSeq
        answer: int = 0
        scores: seq[int] = @[]
        stack: seq[char] = @[]
        points: Table[char, int] = {'(': 1, '[': 2, '{': 3, '<': 4}.toTable
        incomplete = incompleteLines(data)

    for row in incomplete:
        var r = reversed(row)
        var tail: seq[char] = @[]

        for idx, c in r:
            if stack.len > 0 and match(stack[^1], c):
                discard stack.pop()
            elif c in ['(', '[','{','<']:
                tail.add(c)
            else:
                stack.add(c)

        var score = 0
        for i in tail:
            score = score * 5 + points[i]
        scores.add(score)

    scores = sorted(scores)
    answer = scores[(int) scores.len / 2]

    echo "Answer: ", answer