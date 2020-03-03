#Dockerfile with pipenv

# docker image to use
FROM python:3.8-alpine

# add a user so that the app doesn't start with root
RUN adduser -D user1

# maintainer to contact if problem
LABEL maintainer " Gabriel Cournelle <gabriel.cournelle@gmail.com>"

#create project directory 
RUN mkdir /project

# Set work directory (equivalent to cd in bash)
WORKDIR /project

# Install dependencies

COPY Pip* /project/
RUN pip install --upgrade pip && \
    pip install pipenv && \
    pipenv install --dev --system --deploy --ignore-pipfile



# Copy everything in work directory
COPY . /project

#set environment variables
ENV FLASK_APP run.py

# makes user1 the default owner for all files and directories in the project folder
RUN chown -R user1:user1 ./

#makes user1 the default user for subsequent instructions
USER user1

# Expose the port FLask runs on
EXPOSE 5000

# Default command to execute when container is started

CMD flask run --host=0.0.0.0