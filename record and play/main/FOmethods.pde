//FOmethods stands for function object methods.
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.io.FileReader;

class FOmethods {
  File f;
  //the percentage of the total time taken
  BufferedWriter bw = null;
  FileWriter fw = null;

  double timeQuantumPercentage(ArrayList<functionObject> timeline, int index) {
    int total=0;
    for (functionObject c : timeline) {
      total+=c.getFunctionDuration();
    }
    return ((timeline.get(index).getFunctionDuration())/total)*100;
  }

  long parse(String a) {
    String result="";
    for (char c : a.toCharArray()) {
      try {
        Long.parseLong(String.valueOf(c));
        result+=c;
      }
      catch(Exception e) {
        continue;
      }
    }

    return Long.parseLong(result);
  }
//When implementing this feature anywhere other than the processing framework, use serialization to avoid 
//text files. This will mean that you wont have to parse the text file when reading.
  functionObject []loadFromTextFile() throws Exception {
    File file = getPath();
    BufferedReader br = new BufferedReader(new FileReader(file));
    String st;
    ArrayList <Integer> a  =new ArrayList<Integer>();
    ArrayList <Long> b  =new ArrayList<Long>();
    ArrayList <Integer>c = new ArrayList<Integer>();
    while ((st=br.readLine()) != null) {
      if (st.contains("ID")) {
        a.add(Integer.parseInt(String.valueOf(parse(st))));
      } else{
        b.add(parse(st));
      }
    }
    functionObject retValue [] = new functionObject[a.size()];
    for (int i =0; i<a.size(); i++) {
      retValue[i]=new functionObject(b.get(i), a.get(i));
    }
    br.close();
    return retValue;
  }

  File getPath() throws Exception {
    return new File(new File(".").getCanonicalPath()+"\\movements.txt");
  }

  void saveObject(ArrayList<functionObject> timeline) throws Exception {
    f=getPath();
    f.delete();
    if (!f.exists()) {
      f.createNewFile();
    }
    try {
      fw = new FileWriter(f, true);
    }
    catch(Exception e) {
      e.printStackTrace();
    }
    bw = new BufferedWriter(fw);
    try {
      for (functionObject c : timeline) {
        bw.write("ID: "+c.getFunctionID());
        bw.newLine();
        bw.write("Duration: "+String.valueOf(c.getFunctionDuration()));
        bw.newLine();
      }
    } 
    catch (IOException e) {
      e.printStackTrace();
    }
    finally {
      try {
        if (bw != null)
          bw.close();
        if (fw != null)
          fw.close();
      } 
      catch (IOException ex) {
        ex.printStackTrace();
      }
    }
  }
}