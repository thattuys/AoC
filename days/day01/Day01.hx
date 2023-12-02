package days.day01;

import sys.io.File;

class Day01 {
	public function new() {}

	function getNumStr(num:String):String {
		var numStr = "";
		switch (num) {
			case "one": numStr = "1";
			case "two": numStr = "2";
			case "three": numStr = "3";
			case "four": numStr = "4";
			case "five": numStr = "5";
			case "six": numStr = "6";
			case "seven": numStr = "7";
			case "eight": numStr = "8";
			case "nine": numStr = "9";
			default: numStr = num;
		}
		return numStr;
	}

	function getMatches(ereg:EReg, input:String, index:Int = 0):Array<String> {
		var matches = [];
		while (ereg.match(input)) {
			matches.push(getNumStr(ereg.matched(index)));
			input = input.substr(ereg.matchedPos().pos + 1);
		}
		return matches;
	}

	function get_result(rawData:Array<String>, regexp:EReg):Int {
		var finalValue:Int = 0;

		for (line in rawData) {
			var numbers = getMatches(regexp, line);
			var lineValue = Std.parseInt("" + numbers[0] + numbers[numbers.length - 1]);
			finalValue += lineValue;
		}

		return finalValue;
	}

	public function runDay() {
		//var inputs = File.getContent("inputs/01/input-test").split("\n");
		var inputs = File.getContent("inputs/01/input").split("\n");
		trace("partOne: " + get_result(inputs, ~/[0-9]/));
		trace("partTwo: " + get_result(inputs, ~/[0-9]|(one)|(two)|(three)|(four)|(five)|(six)|(seven)|(eight)|(nine)/));
	}
}
