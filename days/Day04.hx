package days;

import sys.io.File;

using StringTools;

class Day04 {
	static var part1:Int = 0;
	static var part2:Int = 0;

	static function calculate_winnings(rawData:Array<String>) {
		var cards:Array<Int> = [for (i in 0...rawData.length) 1];

		for (card in 0...rawData.length) {
			var cleanedLine = rawData[card].split(": ")[1].split(" | ");
			var winnings = cleanedLine[0].split(" ");
			var cardNumbers = cleanedLine[1].split(" ");

			var wins = 0;
			var cardVal = 0;
			for (num in 0...cardNumbers.length) {
				if (winnings.contains(cardNumbers[num])) {
					wins += 1;
					cardVal = (cardVal == 0) ? 1 : cardVal * 2;
				}
			}
			for (i in 0...wins) {
				cards[card + i + 1] += 1 * cards[card];
			}

			part1 += cardVal;
			part2 += cards[card];
		}
	}

	static public function runDay() {
		var rawData = File.getContent("inputs/04/input").replace("  ", " ").replace("\r", "").split("\n");
		calculate_winnings(rawData);
		trace("partOne: " + part1);
		trace("partTwo: " + part2);
	}
}
