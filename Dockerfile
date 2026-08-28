# Stage 1: Install the application dependencies
FROM python:3.12-slim AS builder

# Set the working directory for the build stage
WORKDIR /build

# Copy the dependency file first to benefit from Docker layer caching
COPY app/requirements.txt .

# Install dependencies into a separate directory
RUN pip install \
    --no-cache-dir \
    --prefix=/install \
    -r requirements.txt


# Stage 2: Create the final lightweight runtime image
FROM python:3.12-slim AS runtime

# Create a non-root user for improved container security
RUN useradd --create-home appuser

# Set the application working directory
WORKDIR /app

# Copy only the installed dependencies from the builder stage
COPY --from=builder /install /usr/local

# Copy the application source code
COPY app/main.py .

# Run the application as a non-root user
USER appuser

# Document the port used by the FastAPI application
EXPOSE 8000

# Start the FastAPI application
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]