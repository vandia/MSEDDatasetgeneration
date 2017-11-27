import org.w3c.dom.Document;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.*;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;

/**
 * Created by vandia on 2017-10-08.
 */
public class Transformer {
    public static void main(String[] args) {

        if (args.length< 3) {
            System.out.println("Parameters are not correct");
            return;

        }
        File stylesheet;
        FileWriter fileWriter=null;
        File xmlSources=null;

        try{
            xmlSources = new File(args[0]);
            stylesheet = new File(args[1]);
            fileWriter = new FileWriter(args[2]);
/*
            fileWriter.write ("bug_id,creation_ts,delta_ts,classification,product,component,"+
            "version,op_sys,bug_status,resolution,priority,bug_severity,target_milestone,reporter,assigned_to \r\n");
*/

            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
            DocumentBuilder builder = factory.newDocumentBuilder();


            StreamSource stylesource = new StreamSource(stylesheet);
            javax.xml.transform.Transformer transformer = TransformerFactory.newInstance().newTransformer(stylesource);

            Result outputTarget = new StreamResult(fileWriter);


            for (final File f : xmlSources.listFiles()){
                InputSource in = new InputSource(f.toURI().toASCIIString());
                in.setEncoding("ISO-8859-1");
                Document document = builder.parse(in);
                Source source = new DOMSource(document);
                transformer.transform(source, outputTarget);

            }

        } catch (ParserConfigurationException e) {
            e.printStackTrace();
        } catch (TransformerConfigurationException e) {
            e.printStackTrace();
        } catch (TransformerException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } catch (SAXException e) {
            e.printStackTrace();
        } finally {
            try {
                fileWriter.flush();
                fileWriter.close();
            } catch (Exception e) {
                e.printStackTrace();
            }

        }

    }
}
