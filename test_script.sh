#!/usr/bin/env bash

# Test Java and Maven will display their version details.
if docker run --rm $1 java -version; then
    echo "Java test passed."
    if docker run --rm $1 mvn -version; then
        echo "Maven test passed."
        exit 0
    else
        echo "Maven test Failed!"
        exit 1
    fi
else
    echo "Java test Failed!"
    exit 1
fi

echo "Context escaped!"
exit 1
