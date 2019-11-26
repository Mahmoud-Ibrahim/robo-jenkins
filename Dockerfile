FROM jenkins/jenkins:lts-alpine
USER root 
# RUN echo "http://dl-2.alpinelinux.org/alpine/edge/main" > /etc/apk/repositories
# RUN echo "http://dl-2.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
# RUN echo "http://dl-2.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories


RUN apk add --no-cache  --update openssl openssl-dev python make\
 py-pip python-dev musl-dev gcc libffi-dev chromium chromium-chromedriver  xvfb 
RUN pip install robotframework \
  robotframework-seleniumlibrary \
  robotframework-selenium2library \
  robotframework-sshlibrary \
  robotframework-databaselibrary \
  robotframework-faker \
  robotframework-ftplibrary \
  robotframework-imaplibrary \
  robotframework-pabot\
  robotframework-requests \
  robotframework-seleniumlibrary \
  robotframework-xvfb \
  robotframework-pabot

RUN mv /usr/bin/chromedriver /usr/bin/chromedriver_
RUN mv /usr/lib/chromium/chrome /usr/lib/chromium/chrome_
RUN mv /usr/bin/robot /usr/bin/robot_
RUN echo $'#!/bin/bash\n\
	/usr/bin/chromedriver_ --verbose --log-path=/var/log/chromedriver --no-sandbox $@ '\
	 > /usr/bin/chromedriver

RUN echo $'#!/bin/bash\n\
	/usr/lib/chromium/chrome_ --disable-gpu --no-sandbox $@ '\
	 > /usr/lib/chromium/chrome
RUN echo $'#!/bin/bash\n\
	Xvfb :00 &'\
	 > /start-xvfb.sh

RUN echo $'#!/bin/bash\n\
	Xvfb :00 & \
	/usr/bin/robot_  $@ \n\
	pkill Xvfb \n\
	pkill chrome' 	 > /usr/bin/robot

RUN echo "export DISPLAY=:00" >> /etc/profile
#RUN echo	$'#!/bin/bash\n Xvfb :00 &' > /run/entrypoint.sh
RUN chmod +x   /usr/lib/chromium/chrome   /usr/bin/chromedriver /start-xvfb.sh  /usr/bin/robot  #/run/entrypoint.sh
# RUN . /start-xvfb.sh     #Not workins still

ENV DISPLAY=:00

