# robo-jenkins

By using this file you can test robot framework with jenkins, 
Chrome only.

 docker build -t robo-jenkins  .
 
 docker run -p 8080:8080 --name=test -v "/home/mibrahim:/home/mibrahim" robo-jenkins
