FROM public.ecr.aws/docker/library/ruby:3.3.5-slim-bullseye

ARG APP_NAME

ENV APP_NAME=$APP_NAME \
    DEBIAN_FRONTEND=noninteractive

ENV RAILS_ENV=development