from flask import Flask
import os

# Initialize the Flask application
app = Flask(__name__)

app.config['ENV'] = 'production'

# Define the route for the API
@app.route('/hello', methods=['GET'])
def hello_world():
    # Get the 'NAME' environment variable, defaulting to 'World' if not set
    webtext = os.getenv('WEBTEXT', 'World')  # Default to 'World' if the environment variable is not set
    message = f"Hello, {webtext}!"
    
    print(f"Message sent: {message}")  # This will print the message on the server
    return message

# Run the application
if __name__ == '__main__':
    app.run(debug=False, host="0.0.0.0")  # Ensure the app is accessible from outside the container
