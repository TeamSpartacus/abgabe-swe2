#!/bin/bash


echo "Content-type: text/plain"
echo ""

this=$(echo $QUERY_STRING)
toReturn=""
argumentString=""

parseQueryString(){
    IFS='&' read -r -a array <<< "$this"
    for element in "${array[@]}"
    do
        IFS='=' read -r -a keyVal <<< "$element"
        argumentString+="${keyVal[1]};"
    done
    argumentString=$(sed 's/.$//' <<< "$argumentString")
}

sendRequest(){
    toReturn=$(echo "$argumentString" | ./parser.sh | ./injector.sh)
}

main() {
    parseQueryString
    sendRequest
}
main

echo "$toReturn"