class functionObject {
  //This is used so that it can save a reference to a function and how long it was run for
  private long functionDuration;
  private int functionID;

  static public final int A=0;
  static public final int D=1;


  functionObject(long functionDuration, int functionID) {
    this.functionDuration = functionDuration;
    this.functionID=functionID;
  }

  long getFunctionDuration() {
    return this.functionDuration;
  }
  int getFunctionID() {
    return this.functionID;
  }
}