[课程链接](https://www.bilibili.com/video/BV1oZ4y1B7WS/?spm_id_from=333.788)

### 01 solidity8.0升级点

- 安全数学 unchecked {}

- error 节约gas
- 函数在合约之外的使用
- import {symbol as alias} from "filename";
- salted contract creations /create2  //todo

### 02 HelloWorld

### 03 类型和值

- Bool public b = true;
- uint public u = 23; //`uint = uint256 0 to 2**256-1` `uint8 unit16 ...`
- Int public i = -123; //`int=int256 -2**255 to 2**255-1` `int128 =-2**127 to 2**127-1 `
- int public minInt = type(int).min;
- int public maxInt = type(int).max;
- address public address = 0x4545463....; 
- bytes32 public b32 = 0x...;

### 04 函数

### 05 状态变量

### 06 局部变量

### 07 全局变量

### 08 只读函数

- view 读取状态变量
- pure 

### 09 计数器合约

### 10 默认值

- bool public b;//false
- uint public u; //0
- int public i; //0
- address public a; //0X000000000000000000000000000  40个0
- Byte32 public b32; //0X000000000000000000  64个0

### 11 常量

- address public constant MY_ADDRESS = 0xgfgfd3454535; //节约gas fee
- uint public constant u =123;

### 12 结构控制

### 13 循环

- for(uint i=0;i<10;i++){ if(i==3){ continue;} if(i==5){break;}}
- while(j<10){j++;}

### 14 报错控制

### 15 函数修改器

### 16 构造函数

### 17 Ownable合约

### 18 函数返回值

### 19 数组

### 20，21 删除数组元素

### 22 映射

### 23 映射迭代

### 24 结构体

### 25 枚举

### 26 部署合约

- Proxy0.sol 只能够部署特定合约
- Proxy.sol

### 27 存储位置,28简单存储

- calldata gasfee 比memory少

### 29 待办事情 练习

### 30 事件

### 31,32 继承多线继承

### 3 运行父级合约构造函数

- 实际运行有误

### 34调用父级合约

### 35 可视范围

### 36 不可变量

- immutable 需要在部署的时候赋值。

### 37 支付eth

### 38 回退函数 Fallback receive

### 39 发送主币

### 40 钱包合约 练习

### 41 调用其他合约

### 42 接口合约

### 43 低级调用

### 44 委托调用

### 45 工厂合约

### 46 库合约

### 47 hash

- Keccak256

### 48 验证签名

### 49 权限控制

### 50 自毁合约

- selfdesctruct //向合约强制发布主币的方法

### 51 小猪存钱罐

### 52 erc20

- 满足ierc20接口的合约

### 53 多签钱包

### 54 函数签名

### 55 荷兰拍卖

### 56 英式拍卖

### 57 众筹合约

### 58 create2 salt(不通)

### 59 multi call

- 一次性对多个合约调用
- staticcall

### 60 多重委托调用

- delegatecall只能用于当前合约上

### 61 ABI编码解码

- abi.encode
- Abi.decode

### 62 节约gas

- 输入变量 memory -> calldata

- 循环体中改为内存变量，最后一次性拷入内存

- 短路

  

  ```solidity
  bool isEven=num[i]%2==0;
  bool isLessThan99 = num[i]<99;
  if(isEven && isLessThan99) {}
  -----改为
  if(num[i]%2==0 && num[i]<99) {}
  ```

  

- 循环中 i++ 改为 ++i

- 缓存数组长度 numleng = num.length; for(uint i;i <numleng;++i)
- for(...){uint _num = nums[i]; _num....}

### 63 时间锁合约

































