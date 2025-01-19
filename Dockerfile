FROM python:3.9

# Set the working directory
WORKDIR /app/backend

# Copy the requirements file first to leverage Docker cache
COPY requirements.txt /app/backend/

# Install system dependencies and Python dependencies in one layer to reduce image size
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y gcc default-libmysqlclient-dev pkg-config && \
    rm -rf /var/lib/apt/lists/* && \
    pip install mysqlclient && \
    pip install --no-cache-dir -r requirements.txt

# Copy the application code after installing dependencies to improve caching
COPY . /app/backend/

# Expose the necessary port (default for Django is 8000)
EXPOSE 8000

# Uncomment these if you want to run the migrations during the build process.
# However, it's usually better to run them at container runtime to avoid any issues with build-time DB access.
# RUN python manage.py makemigrations
# RUN python manage.py migrate

# Command to run the application (adjust based on your application)
# CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
