#Front-End Image in NextJS Folder

FROM node:18-alpine AS base

WORKDIR /app

COPY package.json yarn.lock* package-lock.json* pnpm-lock.yaml* ./
#Copy dependencies requirements to container working directory 

RUN \
  if [ -f yarn.lock ]; then yarn --frozen-lockfile; \
  elif [ -f package-lock.json ]; then npm ci; \
  elif [ -f pnpm-lock.yaml ]; then corepack enable pnpm && pnpm i --frozen-lockfile; \
  else echo "Lockfile not found." && exit 1; \
  fi
  
#Install dependencies based on the preferred package manager
COPY . .

RUN npm run build

EXPOSE 3000

CMD ["npm", "start"]

#docker build -t qr-code-frontend .
#docker run -d --name qr-code-frontend -p 3000:3000 qr-code-frontend
#docker tag qr-code-frontend:latest akinace/qr-code-frontend:latest
#docker push akinace/qr-code-frontend:latest