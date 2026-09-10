#API Dockerfile in API Directory 

FROM python:3.9
#Base image name and version

WORKDIR /usr/src/app
#Set the working directory in container 

COPY requirements.txt ./
#copy files to container working directory from present working directory    

RUN pip install --no-cache-dir -r requirements.txt
#Install dependencies listed in requirements.txt No cache dir option avoids caching installed packages, which reduces final image size.

COPY . . 
#Copy all files from the current directory (containing main.py) to the working directory in the container

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "80"]
#Running the application using uvicorn server on port 80 and host



#docker build -t qr-code-api .
#docker run -d --name qr-code-api -p 8000:80 qr-code-api
#docker tag qr-code-api:latest akinace/qr-code-api:latest
#docker push akinace/qr-code-api:latest