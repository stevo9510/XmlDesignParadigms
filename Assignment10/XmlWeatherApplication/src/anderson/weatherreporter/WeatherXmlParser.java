package anderson.weatherreporter;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;

import org.xml.sax.InputSource;
import org.xml.sax.SAXException;
import org.xml.sax.XMLReader;
import org.xml.sax.helpers.XMLReaderFactory;

public class WeatherXmlParser {
	public ArrayList<WeatherCity> parseXml(InputStream in)
    {
        //Create a empty link of users initially
        ArrayList<WeatherCity> weatherCities = null;
        try
        {
            //Create default handler instance
            WeatherParserHandler handler = new WeatherParserHandler();
 
            //Create parser from factory
            XMLReader parser = XMLReaderFactory.createXMLReader();
            
            parser.setDTDHandler(handler);
            
            //Register handler with parser
            parser.setContentHandler(handler);
 
            //Create an input source from the XML input stream
            InputSource source = new InputSource(in);
 
            //parse the document
            parser.parse(source);
 
            //populate the parsed users list in above created empty list; You can return from here also.
            weatherCities = handler.getWeatherCities();
 
        } catch (SAXException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
 
        }
        return weatherCities;
    }
}
