/** 
 * Steven Anderson
 * XML Design Patterns
 * Assignment 10
 * 
 * WeatherParserHandler.java
 *   Handler used to parse standard Weather XML input document and populate a collection of WeatherCity objects.
 */

package anderson.weatherreporter;

import java.util.ArrayList;

import org.xml.sax.Attributes;
import org.xml.sax.SAXException;
import org.xml.sax.SAXParseException;
import org.xml.sax.helpers.DefaultHandler;

public class WeatherParserHandler extends DefaultHandler {
	private static final String CITY_ELEMENT = "CITY";
	private static final String HI_ELEMENT = "HI";
	private static final String LOW_ELEMENT = "LOW";
	private static final String DESCRIPTION_ELEMENT = "DESCRIPTION";
	private static final String ICON_ELEMENT = "ICON";
	
    // List of Weather Cities found during parsing
    private ArrayList<WeatherCity> weatherCities = new ArrayList<WeatherCity>();
    
    // The Current City reference being parsed
    private WeatherCity currentCity;
    
    // The current element being parsed
    private String currentElement;

    // Get weather cities parsed
    public ArrayList<WeatherCity> getWeatherCities()
    {
        return weatherCities;
    }
    
    public void startElement(String uri, String localName, String qName, Attributes attributes) throws SAXException
    {
        //Push it in element stack
    	currentElement = qName;
 
        switch(qName) {
        case CITY_ELEMENT:
            //New Weather City instance
        	currentCity = new WeatherCity();
 
        	// Get Name out of City element
            if(attributes != null && attributes.getLength() == 1)
            {
            	currentCity.setName(attributes.getValue(0));
            }
            
        	break;
        case ICON_ELEMENT:
        	// Get Value attribute out of Icon element
            if(attributes != null && attributes.getLength() == 1)
            {
            	currentCity.setIconName(attributes.getValue(0));
            }
        	break;
        }
    }
 
    public void endElement(String uri, String localName, String qName) throws SAXException
    {
    	currentElement = null;
    	
        // Weather City instance has been constructed so pop it from object stack and push in weatherCityList
        if (CITY_ELEMENT.equals(qName))
        {
            this.weatherCities.add(currentCity);
            currentCity = null;
        }
    }
 
    /**
     * Called every time a parser encounter a value node
     * */
    public void characters(char[] ch, int start, int length) throws SAXException
    {
        String value = new String(ch, start, length).trim();
 
        if (value.length() == 0)
        {
            return; 
        }
        
    	switch(currentElement) {
    	case HI_ELEMENT:
    		try {
    			currentCity.setHigh(Integer.parseInt(value));
    		} catch (NumberFormatException ex) {
    	        System.out.println("Could not parse " + HI_ELEMENT + " element as a number");
    		}
    		break;
    	case LOW_ELEMENT:
    		try {
    			currentCity.setLow(Integer.parseInt(value));
    		} catch (NumberFormatException ex) {
    			System.out.println("Could not parse " + LOW_ELEMENT + " element as a number");
    		}
    		break;
    	case DESCRIPTION_ELEMENT:
    		currentCity.setDescription(value);
    		break;
    	}
    }  
    
    // Log error that occurs when parsing, e.g. DTD validation.  
    // Just writes to System.out now, but ideally this would write to an actual log file of some sort 
    public void error(SAXParseException saxException) {
    	System.out.println(saxException.getMessage());
    }
    
}
