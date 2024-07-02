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
    final _timeStr = time.millisecondsSinceEpoch.toString();
    final _formatTime = _timeStr.substring(0, _timeStr.length - 3);

    return int.parse(_formatTime) ~/ interval;
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
    List<int> _result = [];
    var _input = input;
    while (_input != 0) {
      _result.add(_input! & 0xff);
      _input >>= padding;
    }
    _result.addAll(List<int>.generate(padding, (_) => 0));
    _result = _result.sublist(0, padding);
    _result = _result.reversed.toList();
    return _result;
  }
}