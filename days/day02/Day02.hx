package days.day02;

import haxe.ds.Map;
import sys.io.File;

using StringTools;

class Day02 {
	public function new() {}

	var part1 = 0;
	var part2 = 0;

	function parse_games(rawData:Array<String>) {
		var maxDice:Map<String, Int> = ["red" => 12, "green" => 13, "blue" => 14];

		for (game in rawData) {
			var validGame:Bool = true;
			var minDice:Map<String, Int> = ["red" => 0, "green" => 0, "blue" => 0];

			var lineSplit = game.split(": ");
			var gameNum = Std.parseInt(lineSplit[0].split(" ")[1]);

			for (round in lineSplit[1].split("; ")) {
				for (dice in round.split(", ")) {
					var color = StringTools.replace(dice.split(" ")[1], "\r", "");
					var count = Std.parseInt(dice.split(" ")[0]);

					if (count > maxDice[color]) {
						validGame = false;
					}
					if (count > minDice[color]) {
						minDice[color] = count;
					}
				}
			}
			part1 += validGame ? gameNum : 0;
			part2 += (minDice["red"] * minDice["green"] * minDice["blue"]);
		}
	}

	public function runDay() {
		var input = File.getContent("inputs/02/input").split("\n");
		parse_games(input);
		trace("partOne: " + part1);
		trace("partTwo: " + part2);
	}
}
