FROM nginx:stable-alpine as production-stage
ARG work_dir=~
ENV dir=$work_dir

CMD echo "The directory value is: $dir"
COPY ./dist /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
