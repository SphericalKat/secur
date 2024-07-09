abstract class Util {
  ///
  /// format the time string to int
  ///
  /// @param {time}
  /// @type {Date}
  /// @desc the time need to be format
  ///
  /// @param {interval}
  /// @type {Int}
  /// @desc interval means the one-time password's life,
  /// default to be 30.
  ///
  /// @return {Int}
  ///
  static int timeFormat({required DateTime time, required int interval}) {
    final timeStr = time.millisecondsSinceEpoch.toString();
    final formatTime = timeStr.substring(0, timeStr.length - 3);

    return int.parse(formatTime) ~/ interval;
  }

  ///
  /// transfer the int type to List type
  ///
  /// @param {input}
  /// @type {int}
  /// @desc input param, maybe counter or time
  ///
  /// @return {List}
  ///
  static List intToBytelist({int? input, int padding = 8}) {
    List<int> result = [];
    var input0 = input;
    while (input0 != 0) {
      result.add(input0! & 0xff);
      input0 >>= padding;
    }
    result.addAll(List<int>.generate(padding, (_) => 0));
    result = result.sublist(0, padding);
    result = result.reversed.toList();
    return result;
  }
}