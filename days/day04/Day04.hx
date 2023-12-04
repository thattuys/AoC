package days.day04;

import sys.io.File;

using StringTools;

class Day04 {
	public function new() {}

	var part1:Int = 0;
	var part2:Int = 0;

	function calculate_winnings(rawData:Array<String>) {
		var cards:Array<Int> = [for (i in 0...rawData.length) 1];

		for (card in 0...rawData.length) {
			var cleanedLine = rawData[card].replace("  ", " ").replace("  ", " ").replace("\r\n", "").split(": ")[1];
			var splitCard = cleanedLine.split(" | ");
			var winnings = splitCard[0].split(" ");
			var cardNumbers = splitCard[1].split(" ");

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

			part2 += cards[card];
			part1 += cardVal;
		}
	}

	public function runDay() {
		var rawData = File.getContent("inputs/04/input").replace("\r", "").split("\n");
		calculate_winnings(rawData);
		trace("partOne: " + part1);
		trace("partTwo: " + part2);
	}
}
