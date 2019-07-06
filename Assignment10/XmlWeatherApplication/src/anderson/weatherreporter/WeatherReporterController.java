/** 
 * Steven Anderson
 * XML Design Patterns
 * Assignment 10
 * 
 * WeatherReporterController.java
 *   This is the entry-point servlet that handles web requests to index page. 
 *   Will get resources to route to parser and bind parsed model data to .jsp page. 
 */

package anderson.weatherreporter;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ShowReservationsController
 */
@WebServlet("/WeatherReporter")
public class WeatherReporterController extends HttpServlet {

	private static final long serialVersionUID = -3375260318358292348L;

	/**
     * Default constructor. 
     */
    public WeatherReporterController() {
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doRequest(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doRequest(request, response);
	}

	/**
	 * Handle the request.  If a date parameter is passed, see if it is a valid date.  If so, query results from service and bind to jsp View.  
	 * If date is invalid, then set attribute about invalid date.
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 */
	private void doRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{	
 
        //Create the parser instance
        WeatherXmlParser parser = new WeatherXmlParser();
        	
        // Get Input Sources
        ServletContext context = getServletContext();
        InputStream weatherXML = context.getResourceAsStream("/WEB-INF/Weather.xml");
        InputStream weatherDTD = context.getResourceAsStream("/WEB-INF/Weather.dtd");
       
        //Parse the file
        ArrayList<WeatherCity> weatherCities = parser.parseXml(weatherXML, weatherDTD);

		request.setAttribute("weatherCities", weatherCities);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WeatherReporter.jsp");
		dispatcher.forward(request, response);
	}	
}