# QR Code Generator DevOps Implementation

This is an implementation of DevOps practices to a simple application which generates QR Codes for the provided URL.
The front-end is in NextJS and the API is written in Python using FastAPI.

## Application

**Front-End** - A web application where users can submit URLs.

**API**: API that receives URLs and generates QR codes. The API stores the QR codes in cloud storage (AWS S3 Bucket).

With thanks to the **Author**: [Rishab Kumar](https://github.com/rishabkumar7)

## Steps

- Wrote Docker files to configure images for the front-end and API
- Built and pushed images to DockerHub
- Created GitHub Actions to automate image management
- Deployed AWS EKS cluster using Terraform
- Orchestrated and managed Kubernetes resources with YAML files  

## Running locally

### API

The API code exists in the `api` directory. You can run the API server locally:

- Clone this repo
- Make sure you are in the `api` directory
- Create a virtualenv by typing in the following command: `python -m venv .venv`
- Install the required packages: `pip install -r requirements.txt`
- Create a `.env` file, and add you AWS Access and Secret key, check  `.env.example`
- Also, change the BUCKET_NAME to your S3 bucket name in `main.py`
- Run the API server: `uvicorn main:app --reload`
- Your API Server should be running on port `http://localhost:8000`

### Front-end

The front-end code exits in the `front-end-nextjs` directory. You can run the front-end server locally:

- Clone this repo
- Make sure you are in the `front-end-nextjs` directory
- Install the dependencies: `npm install`
- Run the NextJS Server: `npm run dev`
- Your Front-end Server should be running on `http://localhost:3000`

## License

[MIT](./LICENSE)
