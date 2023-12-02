package days.day02;

import sys.io.File;

using StringTools;

class Day02 {
	public function new() {}

	function part1(rawData:Array<String>):Int {
		var maxDice:Map<String, Int> = ["red" => 12, "green" => 13, "blue" => 14];

		var finalValue:Int = 0;

		for (game in rawData) {
			var lineSplit = game.split(": ");
			var gameNum = Std.parseInt(lineSplit[0].split(" ")[1]);

			var validGame:Bool = true;
			for (round in lineSplit[1].split("; ")) {
				for (dice in round.split(", ")) {
					var color = StringTools.replace(dice.split(" ")[1], "\r", "");
					var count = Std.parseInt(dice.split(" ")[0]);

					if (count > maxDice[color]) {
						validGame = false;
						break;
					}
				}
				if (!validGame) {
					break;
				}
			}
			if (validGame) {
				finalValue += gameNum;
			}
		}

		return finalValue;
	}

	function part2(rawData:Array<String>):Int {
		var minDice:Map<String, Int> = ["red" => 0, "green" => 0, "blue" => 0];

		var finalValue:Int = 0;

		for (game in rawData) {
			var lineSplit = game.split(": ");

			for (round in lineSplit[1].split("; ")) {
				for (dice in round.split(", ")) {
					var color = StringTools.replace(dice.split(" ")[1], "\r", "");
					var count = Std.parseInt(dice.split(" ")[0]);

					if (count > minDice[color]) {
						minDice[color] = count;
					}
				}
			}
			finalValue += (minDice["red"] * minDice["green"] * minDice["blue"]);
			minDice = ["red" => 0, "green" => 0, "blue" => 0];
		}

		return finalValue;
	}

	public function runDay() {
		var input = File.getContent("inputs/02/input").split("\n");
		trace("partOne: " + part1(input));
		trace("partTwo: " + part2(input));
	}
}
