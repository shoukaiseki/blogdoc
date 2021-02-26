# map

```
@startuml
map CapitalCity {
 UK => London
 USA => Washington
 Germany => Berlin
}

map CapitalCity2 {
 UK => London
 USA  => Washington
 Germany => Berlin
}
CapitalCity <|.. CapitalCity2
@enduml
```

## class
```
@startuml

Class01 <|-- Class02:泛化
Class03 <-- Class04:关联
Class05 *-- Class06:组合
Class07 o-- Class08:聚合
Class09 -- Class10

@enduml
```

```
@startuml

Class11 <|.. Class12:实现
Class13 <.. Class14:依赖
Class15 *.. Class16
Class17 o.. Class18
Class19 .. Class20

@enduml
```
@startuml

Class01 "1" *-- "many" Class02 : contains
Class03 o-- Class04 : aggregation
Class05 --> "1" Class06

@enduml
```


```
@startuml

class Car

Driver - Car : drives >
Car *- Wheel : have 4 >
Car -- Person : < owns

@enduml
```
