import std / [sequtils, strutils, tables, algorithm, sets]

var
    lights = readFile("2021/day08/input.txt").strip().split("\n").toSeq
    answer = 0

# Maps the known digits to their set of characters
proc knownPatterns(signals: string): Table[string, HashSet[char]] =
    for signal in signals.splitWhitespace:
        var characters = toHashSet(signal.mapIt(it))

        case signal.len
        of 2:
            result["1"] = characters
        of 3:
            result["7"] = characters
        of 4:
            result["4"] = characters
        of 7:
            result["8"] = characters
        else:
            continue

func isSupersetOf(one: HashSet[char], two: HashSet[char]): bool =
    var match = 0
    for c in two:
        if c in one:
            inc match
    return two.len == match

for light in lights:
    var
        input = light.split("|")
        signal = input[0]
        sumAsString = ""
        patterns: Table[string, HashSet[char]]  = knownPatterns(signal)
        IAMSPECIAL = patterns["4"] - patterns["7"] # Emoji style!

    for value in input[1].splitWhitespace():
        var
            sortedValue = value
            characters = toHashSet(value.mapIt(it))
        sortedValue.sort()

        case value.len
        of 2:
            sumAsString.add("1") 
        of 3:
            sumAsString.add("7")
        of 4:
            sumAsString.add("4")
        of 5:
            if characters.isSupersetOf(patterns["1"]):
                sumAsString.add("3")
            elif not characters.isSupersetOf(patterns["1"]) and characters.isSupersetOf(IAMSPECIAL):
                sumAsString.add("5")
            elif not characters.isSupersetOf(patterns["1"]):
                sumAsString.add("2")
        of 6:
            if characters.isSupersetOf(patterns["1"]) and not characters.isSupersetOf(patterns["4"]):
                sumAsString.add("0")
            elif characters.isSupersetOf(patterns["1"]) and characters.isSupersetOf(patterns["7"]):
                sumAsString.add("9")
            elif not characters.isSupersetOf(patterns["1"]):
                sumAsString.add("6")
        of 7:
            sumAsString.add("8")
        else:
            continue

    if sumAsString.len > 0:
        answer.inc parseInt(sumAsString)

echo "Answer: ", answer
