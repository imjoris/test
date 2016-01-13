#!/bin/bash

#Creational
patternsInGof='
Abstract factory
Builder
Factory
Prototype
Singleton
'

#Structural
patternsInGof="${patternsInGof}"'
Adapter
Bridge
Composite
Decorator
Facade
Flyweight
Proxy
'

#Behavioral
patternsInGof="${patternsInGof}"'
Chain of responsibility
Command
Interpreter
Iterator
Mediator
Memento
Observer
State
Strategy
Template
Visitor
'

echo "$patternsInGof" | while read -r pat; do
    if [[ ! -z "$pat" ]]; then
    echo "$pat";
    grep -lr "$pat" . | while read -r file; do
        printf '\t';
        echo "$file";
    done
fi
done
