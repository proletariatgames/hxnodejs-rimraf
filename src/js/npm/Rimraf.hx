package js.npm;
import js.node.Fs;
import js.node.fs.Stats;
#if haxe4
import js.lib.Error;
#else
import js.Error;
#end

@:jsRequire('rimraf')
extern class Rimraf {
  /**
      The first parameter will be interpreted as a globbing pattern for files. If you want to disable globbing you can do so
      with opts.disableGlob (defaults to false). This might be handy, for instance, if you have filenames that contain
      globbing wildcard characters.

      The callback will be called with an error if there is one. Certain errors are handled for you:

      Windows: EBUSY and ENOTEMPTY - rimraf will back off a maximum of opts.maxBusyTries times before giving up, adding 100ms
      of wait between each attempt. The default maxBusyTries is 3.  ENOENT - If the file doesn't exist, rimraf will return
      successfully, since your desired outcome is already the case.  EMFILE - Since readdir requires opening a file
      descriptor, it's possible to hit EMFILE if too many file descriptors are in use. In the sync case, there's nothing to be
      done for this. But in the async case, rimraf will gradually back off with timeouts up to opts.emfileWait ms, which
      defaults to 1000.
   **/
  @:overload(function(path:String, callback:Null<Error>->Void):Void {})
  @:selfCall public static function rimraf(path:String, options:RimrafOptions, callback:Null<Error>->Void):Void;

  @:overload(function(path:String):Null<Error> {})
  public static function sync(path:String, options:RimrafOptions):Null<Error>;
}

typedef RimrafOptions = {
  /**
    In order to use a custom file system library, you can override specific fs functions on the options object.

    If any of these functions are present on the options object, then the supplied function will be used instead of the
    default fs method.

    Sync methods are only relevant for rimraf.sync(), of course.
   **/
  @:optional function unlink(path:String, callback:Error->Void):Void;
  @:optional function chmod(path:String, mode:FsMode, callback:Error->Void):Void;
  @:optional function stat(path:String, callback:Error->Stats->Void):Void;
  @:optional function lstat(path:String, callback:Error->Stats->Void):Void;
  @:optional function rmdir(path:String, callback:Error->Void):Void;
  @:optional function readdir(path:String, callback:Error->Array<String>->Void):Void;
  @:optional function unlinkSync(path:String):Void;
  @:optional function chmodSync(path:String, mode:FsMode):Void;
  @:optional function statSync(path:String):Stats;
  @:optional function lstatSync(path:String):Stats;
  @:optional function rmdirSync(path:String):Void;
  @:optional function readdirSync(path:String):Array<String>;

  /**
    If an EBUSY, ENOTEMPTY, or EPERM error code is encountered on Windows systems, then rimraf will retry with a linear
    backoff wait of 100ms longer on each try. The default maxBusyTries is 3.

    Only relevant for async usage.
   **/
  var maxBusyTries:Int;

  /**
    If an EMFILE error is encountered, then rimraf will retry repeatedly with a linear backoff of 1ms longer on each
    try, until the timeout counter hits this max. The default limit is 1000.

    If you repeatedly encounter EMFILE errors, then consider using graceful-fs in your program.

    Only relevant for async usage.
   **/
  var emfileWait:Int;

  /**
    Set to false to disable glob pattern matching.

    Set to an object to pass options to the glob module. The default glob options are { nosort: true, silent: true }.

    Glob version 6 is used in this module.

    Relevant for both sync and async usage.
   **/
  var glob:Dynamic;

  /**
    Set to any non-falsey value to disable globbing entirely. (Equivalent to setting glob: false.)
   **/
  var disableGlob:Bool;
}
