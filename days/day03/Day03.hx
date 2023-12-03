package days.day03;

import sys.io.File;

using StringTools;

typedef Vec2 = {
	var y:Int;
	var x:Int;
}

class Day03 {

	public function new() {
	}

	function build_number(pos:Vec2, data:Array<Array<String>>, part:String, validNumbers:Map<String, Int>) {
		var number:String = "";

		// Find the start of the number, if X greater than 0 we subtract 1 from X and check if it is still a number, if it is we loop build_number moving left.
		if (pos.x > 0) {
			if (~/[0-9]/.match(data[pos.y][pos.x - 1])) {
				return build_number({y: pos.y, x: pos.x - 1}, data, part, validNumbers);
			}
		}

		// Run regex from our position and check to see if it is a number, if it is we append it to number
		while (~/[0-9]/.match(data[pos.y][pos.x])) {
			number += data[pos.y][pos.x];
			pos.x += 1;
			if (pos.x >= data[pos.y].length) { // Break out if we hit the end of the row
				break;
			}
		}

		// Check to see if number had anything written to it and that the key does not exist in valid numbers
		if (number.length != 0 && !validNumbers.exists("Y:" + pos.y + "X:" + pos.x + "P:" + part)) {
			// Convert our number to an int and store it in our map
			validNumbers["Y:" + pos.y + "X:" + pos.x + "P:" + part] = Std.parseInt(number);
		}

		return;
	}

	function find_adjacent_numbers(pos:Vec2, data:Array<Array<String>>, part:String, dataMap:Map<String, Int>) {
		if (pos.y > 0) // Top
			if (~/[0-9]/.match(data[pos.y - 1][pos.x]))
				build_number({y: pos.y - 1, x: pos.x}, data, part, dataMap);

		if (pos.x > 0) // Left
			if (~/[0-9]/.match(data[pos.y][pos.x - 1]))
				build_number({y: pos.y, x: pos.x - 1}, data, part, dataMap);

		if (pos.x > 0 && pos.y > 0) // Top Left
			if (~/[0-9]/.match(data[pos.y - 1][pos.x - 1]))
				build_number({y: pos.y - 1, x: pos.x - 1}, data, part, dataMap);

		if (pos.y < data.length - 1) // Bottom
			if (~/[0-9]/.match(data[pos.y + 1][pos.x]))
				build_number({y: pos.y + 1, x: pos.x}, data, part, dataMap);

		if (pos.x < data[pos.y].length - 1) // Right
			if (~/[0-9]/.match(data[pos.y][pos.x + 1]))
				build_number({y: pos.y, x: pos.x + 1}, data, part, dataMap);

		if (pos.y < data.length - 1 && pos.x < data[pos.y].length - 1) // Bottom Right
			if (~/[0-9]/.match(data[pos.y + 1][pos.x + 1]))
				build_number({y: pos.y + 1, x: pos.x + 1}, data, part, dataMap);

		if (pos.y > 0 && pos.x < data[pos.y].length - 1) // Top Right
			if (~/[0-9]/.match(data[pos.y - 1][pos.x + 1]))
				build_number({y: pos.y - 1, x: pos.x + 1}, data, part, dataMap);

		if (pos.y < data[pos.y].length - 1 && pos.x > 0) // Bottom Left
			if (~/[0-9]/.match(data[pos.y + 1][pos.x - 1]))
				build_number({y: pos.y + 1, x: pos.x - 1}, data, part, dataMap);
	}

	function part1(rawData:Array<String>):Int {
		var validNumbers:Map<String, Int> = new Map<String, Int>(); 
		var dataMatrix = new Array<Array<String>>();
		for (i in rawData) {
			dataMatrix.push(i.split(""));
		}
		for (y in 0...dataMatrix.length - 1) {
			for (x in 0...dataMatrix[y].length - 1) {
				if (!~/[0-9]|(\.)/.match(dataMatrix[y][x])) { // If our current cell is not a number or . then branch off and find our numbers
					find_adjacent_numbers({x: x, y: y}, dataMatrix, dataMatrix[y][x], validNumbers);
				}
			}
		}

		var finalValue:Int = 0;
		for (x in validNumbers) {
			finalValue += x;
		}

		return finalValue;
	}

	function part2(rawData:Array<String>):Int {
		var dataMatrix = new Array<Array<String>>();
		for (i in rawData) {
			dataMatrix.push(i.split(""));
		}

		var finalValue:Int = 0;
		for (y in 0...dataMatrix.length - 1) {
			for (x in 0...dataMatrix[y].length - 1) {
				if (dataMatrix[y][x] == "*") { // If our current cell is not a number or . then branch off and find our numbers
					var gears:Map<String, Int> = new Map<String, Int>();
					find_adjacent_numbers({x: x, y: y}, dataMatrix, dataMatrix[y][x], gears);
					var firstGear:Int = 0;
					for (gear in gears.keys()) {
						if (firstGear == 0) {
							firstGear = gears[gear];
						} else {
							finalValue += firstGear * gears[gear];
						}
					}
				}
			}
		}
		return finalValue;
	}

	public function runDay() {
		var rawData = File.getContent("inputs/03/input").replace("\r", "").split("\n");
		trace("partOne: " + part1(rawData));
		trace("partTwo: " + part2(rawData));
	}
}
