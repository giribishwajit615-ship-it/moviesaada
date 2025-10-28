FROM python:3.10-slim
# install git first
RUN apt-get update && apt-get install -y git

# create app dir and copy code
WORKDIR /app
COPY . /app

# upgrade pip and install requirements
RUN pip install --upgrade pip && pip install -r requirements.txt

EXPOSE 8080

# start command (change bot.py if file name different)
CMD ["python", "bot.py"]
