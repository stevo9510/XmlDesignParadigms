package anderson.weatherreporter;

public class WeatherCity {

	private String name;
	private String high;
	private String low;
	private String description;
	private String iconName;
	
	public WeatherCity(String name, String high, String low, String description, String iconName) {
		this.name = name;
		this.high = high;
		this.low = low;
		this.description = description;
		this.iconName = iconName;
	}
	
	public String getName() {
		return name;
	}
	public String getHigh() {
		return high;
	}
	public String getLow() {
		return low;
	}
	public String getDescription() {
		return description;
	}
	public String getIconName() {
		return iconName;
	}
	
}
