# Use Python 3.10 (cinemagoer ke liye >=3.9 chahiye)
FROM python:3.10-slim

# Prevent Python writing pyc files and buffering stdout
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app

# Install system build deps needed for some pip packages (optional but safe)
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    gcc \
    libffi-dev \
    && rm -rf /var/lib/apt/lists/*

# Copy only requirements first to use cache better
COPY requirements.txt .

# Upgrade pip and install Python deps
RUN python -m pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

# Now copy the rest of the repo
COPY . .

# Expose whatever port your app uses (change if needed)
EXPOSE 8080

# Start command — change to your start file
CMD ["python", "app.py"]
