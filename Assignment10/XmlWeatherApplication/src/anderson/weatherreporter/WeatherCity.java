/** 
 * Steven Anderson
 * XML Design Patterns
 * Assignment 10
 * 
 * WeatherCity.java
 *   Represents a Weather City data model/POJO object.  Contains information about the weather of a particular city.
 */

package anderson.weatherreporter;

public class WeatherCity {

	private String name;
	private int high;
	private int low;
	private String description;
	private String iconName;
	
	public WeatherCity() {
	}
	
	public String getName() {
		return name;
	}
	public int getHigh() {
		return high;
	}
	public int getLow() {
		return low;
	}
	public String getDescription() {
		return description;
	}
	public String getIconName() {
		return iconName;
	}

	public void setName(String name) {
		this.name = name;
	}
	public void setHigh(int high) {
		this.high = high;
	}
	public void setLow(int low) {
		this.low = low;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public void setIconName(String iconName) {
		this.iconName = iconName;
		// Append .gif if it does not exist
		if(!this.iconName.endsWith(".gif")) {
			this.iconName = this.iconName.concat(".gif");
		}
	}

    @Override
    public String toString() {
        return this.name + ":" + this.high +  ":" + this.low + ":" + this.iconName + ":" + this.description;
    }
	
}
