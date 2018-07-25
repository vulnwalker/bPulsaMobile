class ConfigClass {
  String hostName ;
  String getHostName(){
    this.hostName = "http://bpulsa.rm-rf.studio/";
    return this.hostName;
  }
  String auth(){
    return getHostName()+"auth";
  }
}