FROM node:10.15.1-alpine as build

# project-specific information
WORKDIR /root

# copy in pinned code dependency file(s)
COPY ./package.json /root/package.json
COPY ./package-lock.json /root/package-lock.json

# download/install dependencies by pinned version
RUN npm ci

# get working tree information from build script
# TODO: inject these into npm build
# ARG GIT_BRANCH
# ARG GIT_COMMIT_NUM
# ARG GIT_COMMIT
# ARG CHANGED

# bring in source files
COPY ./public/ /root/public
COPY ./src/ /root/src

# perform actual build
RUN npm run build



# create final container
FROM nginx:1.15.8-alpine

# add static dependencies
# RUN apk add --no-cache gettext # uncomment to use nginx.conf templating

# add dependencies
COPY ./nginx.conf /etc/nginx/nginx.conf

# copy final resources from last build stage
COPY --from=build /root/build /var/www

# startup command
CMD ["nginx", "-g", "daemon off;"]
# CMD envsubst "$IP_ADDR" "$<env var>"... < /etc/nginx/nginx.conf > /etc/nginx/nginx.conf && nginx -g 'daemon off;' # use instead for nginx.conf templating