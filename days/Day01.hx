package days;

import sys.io.File;

class Day01 {
	static function get_result(rawData:Array<String>, regexp:EReg):Int {
		var finalValue:Int = 0;

		var numberString = [
			"one" => "1", "two" => "2", "three" => "3", "four" => "4", "five" => "5", "six" => "6", "seven" => "7", "eight" => "8", "nine" => "9",
			  "1" => "1",   "2" => "2",     "3" => "3",    "4" => "4",    "5" => "5",   "6" => "6",     "7" => "7",     "8" => "8",    "9" => "9"
		];

		for (line in rawData) {
			var numbers:Array<String> = new Array<String>();
			while (regexp.match(line)) {
				numbers.push(numberString[regexp.matched(0)]);
				line = line.substr(regexp.matchedPos().pos + 1);
			}

			var lineValue = Std.parseInt("" + numbers[0] + numbers[numbers.length - 1]);
			finalValue += lineValue;
		}

		return finalValue;
	}

	static public function runDay() {
		// var inputs = File.getContent("inputs/01/input-test").split("\n");
		var inputs = File.getContent("inputs/01/input").split("\n");
		trace("partOne: " + get_result(inputs, ~/[0-9]/));
		trace("partTwo: " + get_result(inputs, ~/[0-9]|(one)|(two)|(three)|(four)|(five)|(six)|(seven)|(eight)|(nine)/));
	}
}
