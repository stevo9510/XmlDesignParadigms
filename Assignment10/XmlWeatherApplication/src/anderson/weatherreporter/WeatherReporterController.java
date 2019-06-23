package anderson.weatherreporter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
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
		List<WeatherCity> cities = new ArrayList<WeatherCity>();
		cities.add(new WeatherCity("foo", "bar", "go", "yo", "sup"));
		cities.add(new WeatherCity("abc", "def", "fgh", "ijk", "lmn"));
		
		request.setAttribute("weatherCities", cities);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WeatherReporter.jsp");
		dispatcher.forward(request, response);
	}	
}