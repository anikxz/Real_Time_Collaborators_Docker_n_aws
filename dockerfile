#build the frontend [dist folder]
#copy the dist folder contain to Backend/public folder

FROM: node:20-alpine as frontend-builder

COPY ./Frontend /app

WORKDIR /app 
# whole working directory is /app

RUN npm install
RUN npm run build

#build the backend
FROM node:20-alpine
COPY ./Backend /app

WORKDIR /app

RUN npm install

COPY --from=frontend-builder /app/dist /app/public
#RUN npm install >> if node modules is not copied
CMD ["node", "server.js" ]
