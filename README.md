## Java8_docker_image
###### Please send any questions, queries or concerns to: `java8docker@blairjames.com`
- OpenJDK8 and Maven 3.6.3 for Java Development.
- Static and Stable to avoid instability and inconsistency.
- CI/CD built, monitored and tested regularly.
- Clean, single concern container.

#### Usage:
###### The container can run Java or Maven as executables:
``` 
- docker run --rm blairy/java8 java -version
- docker run --rm blairy/java8 mvn -version
```

###### Or as an interactive terminal session by adding the "-it" flags:
```
- docker run -it --rm blairy/java8
```

 ###### Note the "--rm" flag. This removes the container from memory upon exit.

