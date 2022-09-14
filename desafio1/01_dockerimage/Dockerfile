FROM alpine:3.16.2

RUN apk add git python3 py3-pip
RUN pip3 install flask
RUN mkdir /simpleapp
RUN git clone https://github.com/tempestsecurity/simpleapp-python /simpleapp

WORKDIR /simpleapp

EXPOSE 80

CMD ["python3", "app.py"]
