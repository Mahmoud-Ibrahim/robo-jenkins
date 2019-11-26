# robo-jenkins

By using this file you can test robot framework with jenkins, 
Chrome only.

 docker build -t robo-jenkins  .
 
 docker run -p 8080:8080 --name=test -v "/home/robot_directory:/home/robot_director" robo-jenkins
 
 
 # robot files should be in /home/robot_director 
 # you can change the location before running.  
