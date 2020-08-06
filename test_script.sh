
# test java -version and mvn -version
if docker run --rm blairy/java8:$timestp -version; then
    
else
    except "Tests failed!"
fi
