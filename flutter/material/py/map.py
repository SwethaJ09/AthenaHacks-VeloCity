import folium
import requests
import geopy
from geopy.geocoders import Nominatim

def get_coordinates_from_place_name(place_name):
    geolocator = Nominatim(user_agent="geo_locator")
    
    location = geolocator.geocode(place_name)

    if not location:
        print(f"No results found for the place name: {place_name}")
        return None

    latitude, longitude = location.latitude, location.longitude
    return latitude, longitude

def fetch_route_coordinates(origin_coordinates, destination_coordinates):
    # Get alternative directions from the OpenStreetMap API
    url = f"https://router.project-osrm.org/route/v1/driving/{origin_coordinates[1]},{origin_coordinates[0]};{destination_coordinates[1]},{destination_coordinates[0]}?overview=full&geometries=geojson&alternatives=true"
    response = requests.get(url)
    data = response.json()

    # Print the data for debugging
    print("OSRM API Response:", data)

    # Check if the data contains alternative route information
    if "routes" in data and data["routes"]:
        # Extract coordinates for the first route
        coordinates = [(coord[1], coord[0]) for coord in data["routes"][0]["geometry"]["coordinates"]]
        return coordinates
    else:
        print("No route information found in the API response.")
        return None

def generate_and_store_routes(origin_place_name, destination_place_name, route_coordinates_arrays):
    # Get coordinates for the origin and destination
    origin_coordinates = get_coordinates_from_place_name(origin_place_name)
    destination_coordinates = get_coordinates_from_place_name(destination_place_name)

    if not origin_coordinates or not destination_coordinates:
        print("Error: One or both places not found.")
        return

    # Fetch route coordinates from the API for the first route
    route1_coordinates = fetch_route_coordinates(origin_coordinates, destination_coordinates)

    if route1_coordinates:
        # Update the route_coordinates_arrays with the coordinates for the first route
        route_coordinates_arrays.append(route1_coordinates)

        # Create a map object for the first route
        map_route1 = folium.Map(location=origin_coordinates, zoom_start=10)

        # Add the first route polyline to the map in blue
        folium.PolyLine(route1_coordinates, color="blue", weight=5, opacity=0.7, line_cap='round', line_join='round', tooltip="Route 1").add_to(map_route1)

        # Add markers for the origin and destination
        folium.Marker(location=origin_coordinates, icon=folium.Icon(color="green")).add_to(map_route1)
        folium.Marker(location=destination_coordinates, icon=folium.Icon(color="red")).add_to(map_route1)

        # Save the first map as an HTML file
        map_route1.save("map_route1.html")
        print("Map for Route 1 saved as map_route1.html. Open this file in a web browser to view the map.")

        # Fetch route coordinates from the API for the second route
        route2_coordinates = fetch_route_coordinates(destination_coordinates, origin_coordinates)

        if route2_coordinates:
            # Update the route_coordinates_arrays with the coordinates for the second route
            route_coordinates_arrays.append(route2_coordinates)

            # Create a map object for the second route
            map_route2 = folium.Map(location=origin_coordinates, zoom_start=10)

            # Add the second route polyline to the map in orange
            folium.PolyLine(route2_coordinates, color="orange", weight=5, opacity=0.7, line_cap='round', line_join='round', tooltip="Route 2").add_to(map_route2)

            # Add markers for the origin and destination
            folium.Marker(location=origin_coordinates, icon=folium.Icon(color="green")).add_to(map_route2)
            folium.Marker(location=destination_coordinates, icon=folium.Icon(color="red")).add_to(map_route2)

            # Save the second map as an HTML file
            map_route2.save("map_route2.html")
            print("Map for Route 2 saved as map_route2.html. Open this file in a web browser to view the map.")
        else:
            print("Failed to fetch coordinates for the second route.")
    else:
        print("Failed to fetch coordinates for the first route.")

# Example usage:
origin_place_name = "Mylapore"
destination_place_name = "Ambattur"

# Assuming route_coordinates_arrays is a list containing arrays of coordinates for existing routes
# You need to replace this with the actual array in your program.
route_coordinates_arrays = []

generate_and_store_routes(origin_place_name, destination_place_name, route_coordinates_arrays)
