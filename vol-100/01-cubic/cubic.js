"use strict";

var line_reader = {
  each_line: function(cb)
  {
    this._on_each_line = cb;
    return this;
  },
  start: function()
  {
    var that = this;
    process.stdin.resume();
    process.stdin.setEncoding('utf8');
    process.stdin.on('data', function(chunk) {
      that._input += chunk;
      for(;;)
      {
        var pos = that._input.indexOf('\n');
        if( pos == -1 )
        {
          break;
        }
        var line = that._input.substr(0, pos + 1);
        that._dispatch(line);
        that._input = that._input.substr(pos + 1);
      }
    });
    process.stdin.on('end', function() {
      if( that._input !== '' )
      {
        that._dispatch(that._input);
      }
    });
  },
  _dispatch: function(line)
  {
    var cb = this._on_each_line;
    if( cb )
    {
      cb.call(this, line);
    }
  },
  _input: '',
  _on_each_line: undefined
};

function main()
{
  line_reader.each_line(function(line){
    var m = line.match(/^(\d+)\n/);
    if( m )
    {
      var num = m[1];
      console.log( cubic(num) );
    }
  }).start();
}

function cubic(num)
{
  return num * num * num;
}

main();
