# test1

```
@startuml
'left to right direction
top to bottom direction
skinparam usecase {
BackgroundColor<< 未完成 >> #ed5565
'BorderColor<< 未完成 >> #ed5565

BackgroundColor<< 完成 >> #1ab394
'BorderColor<< 完成 >> #1ab394

BackgroundColor<< 进行中 >> #f8ac59
'BorderColor<< 进行中 >> #f8ac59

BackgroundColor<< 未选择 >> Gray
'BorderColor<< 未选择 >> Gray

ArrowColor Indigo
}
skinparam package {
BackgroundColor<< 未完成 >> #ed5565
'BorderColor<< 未完成 >> #ed5565

BackgroundColor<< 完成 >> #1ab394
'BorderColor<< 完成 >> #1ab394

BackgroundColor<< 进行中 >> #f8ac59
'BorderColor<< 进行中 >> #f8ac59

BackgroundColor<< 未选择 >> Gray
'BorderColor<< 未选择 >> Gray

'ArrowColor Olive
}
usecase "销售下单"  as 销售 << 完成 >>
usecase "设计图纸" as 设计  << 完成 >>
package 选择车间  << 进行中 >>{
  package 车间1生产工序 << 未选择 >> {
      usecase "车间主任1" as 车间主任1 << 未选择 >>
      package 并行工序1 << 未选择 >> {
          usecase "主机组装1" as 主机组装1 << 未选择 >>
          usecase "显示器组装1" as 显示器组装1 << 未选择 >>
          usecase "配件包装1" as 配件包装1 << 未选择 >>
      }
      usecase "检验1" as 检验1 << 未选择 >>

  }
  package 车间2生产工序 << 进行中 >> {
      usecase "车间主任2" as 车间主任2 << 完成 >>
      package 并行工序2 << 进行中 >> {
          usecase "主机组装2" as 主机组装2 << 进行中 >>
          usecase "显示器组装2" as 显示器组装2 << 进行中 >>
          usecase "配件包装2" as 配件包装2 << 完成 >>
          usecase "检验主机组装2" as 检验主机组装2 << 未完成 >>
          usecase "检验显示器组装2" as 检验显示器组装2 << 未完成 >>
          usecase "检验配件包装2" as 检验配件包装2 << 完成 >>
      }
  }
}
note left of 选择车间 : 此为选择子流程节点,子流程设置为可编辑.
note right of 并行工序1 : 此为并行子流程节点,所有子流程可同时进行生产,全部完成后该节点才算完成.

usecase "销售接到通知" as 销售接到完工消息 << 未完成 >>

销售 -down-> 设计
设计 -down-> 车间1生产工序
设计 -down-> 车间2生产工序

车间主任1 -down-> 主机组装1
车间主任1 -down-> 显示器组装1
车间主任1 -down-> 配件包装1

主机组装1 -down-> 检验1
显示器组装1 -down-> 检验1
配件包装1 -down-> 检验1

车间主任2 -down-> 主机组装2
车间主任2 -down-> 显示器组装2
车间主任2 -down-> 配件包装2

主机组装2 -down-> 检验主机组装2
显示器组装2 -down-> 检验显示器组装2
配件包装2 -down-> 检验配件包装2

检验1 -down-> 销售接到完工消息
检验主机组装2 -down-> 销售接到完工消息
检验显示器组装2 -down-> 销售接到完工消息
检验配件包装2 -down-> 销售接到完工消息

@enduml

```


