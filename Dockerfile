# Use the official Python image from the Python Docker Hub repository as the base image
FROM python:3.11.4-slim-bullseye

# Set the working directory to /app in the container
WORKDIR /app

# Create a non-root user named 'myuser' with a home directory
RUN useradd -m myuser

# Copy the requirements.txt file to the container to install Python dependencies
COPY requirements.txt ./

# Install the Python packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Before copying the application code, create the logs and qr_codes directories
# and ensure they are owned by the non-root user
RUN mkdir logs qr_codes && chown myuser:myuser logs qr_codes

# Copy the rest of the application's source code into the container, setting ownership to 'myuser'
COPY --chown=myuser:myuser . .

# Switch to the 'myuser' user to run the application
USER myuser

# Use the Python interpreter as the entrypoint and the script as the first argument
# This allows additional command-line arguments to be passed to the script via the docker run command
ENTRYPOINT ["python", "main.py"]
# this sets a default argument, its also set in the program but this just illustrates how to use cmd and override it from the terminal
CMD ["--url","https://github.com/vinaykath"]



# # Use the official Python image from the Docker Hub
# FROM python:3.11.4-slim

# # Set the working directory in the container
# WORKDIR /app

# # Copy the requirements file into the container
# COPY requirements.txt .

# # Install the required Python packages
# RUN pip install --no-cache-dir -r requirements.txt

# # Copy the rest of the application code into the container
# COPY . .

# # Run the application
# CMD ["python", "app.py"]
