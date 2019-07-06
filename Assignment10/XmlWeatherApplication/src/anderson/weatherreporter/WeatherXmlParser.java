/** 
 * Steven Anderson
 * XML Design Patterns
 * Assignment 10
 * 
 * WeatherXmlParser.java
 *   Creates a SAX Parser using WeatherParserHandler and parses a provided XML Input document.
 */

package anderson.weatherreporter;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;

import javax.xml.parsers.ParserConfigurationException;
import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;

import org.xml.sax.EntityResolver;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;
import org.xml.sax.XMLReader;

public class WeatherXmlParser {
	public ArrayList<WeatherCity> parseXml(InputStream xmlIn, InputStream dtdIn)
    {
        //Create a empty link of users initially
        ArrayList<WeatherCity> weatherCities = null;
        try
        {
            //Create default handler instance
            WeatherParserHandler weatherParserHandler = new WeatherParserHandler();
 
            // Setup Factory to support DTD Validation
            SAXParserFactory factory = SAXParserFactory.newInstance();
            factory.setValidating(true); 
            factory.setNamespaceAware(true);
                        
            // Create parser from factory, and get reader
            SAXParser parser = factory.newSAXParser();
            final XMLReader xmlReader = parser.getXMLReader();
            
            // Setup Resolver for Fetching DTD file and Set Handler
            xmlReader.setEntityResolver(new DtdInputStreamEntityResolver(dtdIn));
            xmlReader.setDTDHandler(weatherParserHandler);
            xmlReader.setContentHandler(weatherParserHandler);
            xmlReader.setErrorHandler(weatherParserHandler);
            
            // Parse the Input XML
            xmlReader.parse(new InputSource(xmlIn));
 
            // Get the Parsed Data (Weather Cities)
            weatherCities = weatherParserHandler.getWeatherCities();

        } catch (SAXException e) {
			e.printStackTrace();
		} catch (ParserConfigurationException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
        return weatherCities;
    }
	
	/**
	 * Entity Resolver that Takes in an DTD Input Stream to use when resolving DTD Entity
	 * This is used to prevent FileNotFound IO exception against DTD file because it does not necessarily search for the DTD
	 * relative to the XML document location.
	 */
	private class DtdInputStreamEntityResolver implements EntityResolver {

		private InputStream dtdInputStream;
		
		public DtdInputStreamEntityResolver(InputStream dtdInputStream) {
			this.dtdInputStream = dtdInputStream;
		}
		
		@Override
		public InputSource resolveEntity(String publicId, String systemId) throws SAXException, IOException {
	        if (systemId.contains(".dtd")) {
	            return new InputSource(dtdInputStream);
	        } else {
	            return null;
	        }		
        }
	}
}
