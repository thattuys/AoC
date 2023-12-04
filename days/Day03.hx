package days;

import sys.io.File;

using StringTools;

class Day03 {
	static var part1:Int = 0;
	static var part2:Int = 0;

	static function build_number(y:Int, x:Int, data:Array<Array<String>>, part:String, validNumbers:Map<String, Int>) {
		var number:String = "";

		if (!~/[0-9]/.match(data[y][x]))
			return;

		// Find the start of the number, if X greater than 0 we subtract 1 from X and check if it is still a number, if it is we loop build_number moving left.
		if (x > 0) {
			if (~/[0-9]/.match(data[y][x - 1])) {
				return build_number(y, x - 1, data, part, validNumbers);
			}
		}

		if (validNumbers.exists("Y:" + y + "X:" + x))
			return;

		// Run regex from our position and check to see if it is a number, if it is we append it to number
		while (~/[0-9]/.match(data[y][x])) {
			number += data[y][x];
			x += 1;
			if (x >= data[y].length) // Break out if we hit the end of the row
				break;
		}

		if (number.length != 0)
			validNumbers["Y:" + y + "X:" + x] = Std.parseInt(number);

		return;
	}

	static function calculate(dataMatrix:Array<Array<String>>) {
		var numberCords:Array<String> = new Array<String>();

		for (y in 0...dataMatrix.length - 1) {
			for (x in 0...dataMatrix[y].length - 1) {
				if (!~/[0-9]|(\.)/.match(dataMatrix[y][x])) { // If our current cell is not a number or . then branch off and find our numbers
					var matches:Map<String, Int> = new Map<String, Int>();
					var firstGear:Int = 0;

					for (yy in -1...2) {
						if (y + yy >= dataMatrix.length || y + yy < 0)
							continue;
						for (xx in -1...2) {
							if (x + xx >= dataMatrix[y].length || x + xx < 0)
								continue;
							build_number(y + yy, x + xx, dataMatrix, dataMatrix[y][x], matches);
						}
					}

					for (key in matches.keys()) {
						if (!numberCords.contains(key)) {
							numberCords.push(key);
							part1 += matches[key];
						}

						if (dataMatrix[y][x] == "*") { // Part 2: if the part is * and has 2 numbers, multiply them together and add them to part 2.
							if (firstGear == 0) {
								firstGear = matches[key];
							} else {
								part2 += firstGear * matches[key];
							}
						}
					}
				}
			}
		}
	}

	static public function runDay() {
		var rawData = File.getContent("inputs/03/input").replace("\r", "").split("\n");
		var dataMatrix = new Array<Array<String>>();
		for (i in rawData)
			dataMatrix.push(i.split(""));

		calculate(dataMatrix);
		trace("partOne: " + part1);
		trace("partTwo: " + part2);
	}
}
