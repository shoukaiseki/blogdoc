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


![image](http://www.plantuml.com/plantuml/png/xLRHJjDG6Bu_Jt625zm0oQepOWX1l31U-GnbxUR2w25TaHYoPA1Bc0oO2OeA2I4mdIGKBtIEJURBz9osR-7A7qhxzx3q0IGXiEzy_tV-xtodVpTNjbJJMbagaV6IdhUenQXPBBoqg5OqzPnLP0Qns780Bp3BOaiHlBnOD9PLKrsYAsKzfvPrkaRcrTnYmMGhXlQKbPWvCqF5uHct6sApIMTdwJrTosOVPiduF3CrtHp9aMX5I1bruVxq0oGa8KXKlBy7td73wPvVy_AFr5ns6Wd9EN9tVhKkjhu7l6Uc-Xe9IGZaYMcorUjr-jpGYWL6Af6pN1xkeHRIdUN_inoF7EQBKl6LJYhavZQE-NjLlcSxtIs-_M6CKhLC0Q5HTxTqpnvuzZ4_6BYzxbZ01e36wJVvG2VUrLT__oUboEOQeM6GGCcuUqTExnl_tUAzNOhD1FpW9-m5Yfnkt-dtCz1C5C42K1vkoIyxmrPWhymTcw4DXyBYiEVsttedDTWmXc0HcOJuD71FU_npEwg2m5H2VctRwNTuenQgXCW8YGh1_PnK_RC62C3_oL8IrE6i59nLDDhHMIc9h9J8zHaPb89sIX6KaWWAYwG9Ia51fHF2GIc9eAJE9Gab7Kbm2icba9Exaowb5qqwbU0olnKI_5Q8mIoTNhzXMJu-EnvJSNxgT7i0ylEc-BNkjhUyTnlknkN4xMTxu5xPGnxVlN3_VFG6xwT055xNB1z_waDPGB6ig5V5OJr4XvgysH3x7KWSxly4hxNzDsrmn9ixtaKBgaLzsxNt0PyYUDwAdHRV_E5NlxX7BRWJ4PZRGOEYiodMBnAdJu199pMsQapEKfY_1Fw4g6IUoYbAZ49Y0pIangQSd9EOON9QV4WH4bMEQC4W8bWpGGZLPAjnDuhKZO8vs8sK9dMZnDs49Dc3YfrXCbwE6SLar0I0uMdSURE8fA-qHRY_L7MerHH5P4utjE1hzpy0)
