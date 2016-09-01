# Now we may need to build it first by firing
# npm install
# npm run build
# Then use this Dockerfile to host them
# Let's find another way to combine them
# Maybe use ubuntu as base image then install npm and nginx
FROM nginx:stable
COPY ./dist/ /usr/share/nginx/html
