import std/[sequtils, strutils]

var
    lights = readFile("2021/day08/input.txt").strip().split("\n").toSeq
    answer = 0

for light in lights:
    echo "\nlight: ", light

    var outputs = light
            .split("|")[1]
            .strip()
            .split()

    for output in outputs:
        case output.len
        of 2: inc answer    # 1
        of 4: inc answer    # 4
        of 3: inc answer    # 7
        of 7: inc answer    # 8
        else: continue

echo "Answer: ", answer