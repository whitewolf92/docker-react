From node:alpine as builder

WORKDIR '/app'

COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# AWS will automatically look at the expose port and use it
FROM nginx 
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html