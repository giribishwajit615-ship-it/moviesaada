# # force Python >=3.9
FROM python:3.10-slim

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app

# (Optional) needed build tools for some pip packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential gcc libffi-dev \
    && rm -rf /var/lib/apt/lists/*

# cachebust ARG (helps when platform reuses layers)
ARG CACHEBUST=1
RUN echo "cachebust=${CACHEBUST}"

# copy requirements and install
COPY requirements.txt /app/requirements.txt
RUN python -m pip install --upgrade pip
RUN pip install --no-cache-dir -r /app/requirements.txt

# copy rest of project
COPY . /app

EXPOSE 8080
CMD ["python", "app.py"]
