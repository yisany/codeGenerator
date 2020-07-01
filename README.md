# Code-Generator

![image](https://img.shields.io/badge/SpringBoot2-%E2%98%85%E2%98%85%E2%98%85%E2%98%85%E2%98%85-brightgreen.svg)
![image](https://img.shields.io/badge/Freemarker-%E2%98%85%E2%98%85%E2%98%85%E2%98%85%E2%98%85-brightgreen.svg)
![image](https://img.shields.io/badge/CodeGenerator-%E2%98%85%E2%98%85%E2%98%85%E2%98%85%E2%98%85-brightgreen.svg)
[![Build Status](https://travis-ci.org/moshowgame/SpringBootCodeGenerator.svg?branch=master)](https://travis-ci.org/moshowgame/SpringBootCodeGenerator)

这是@[yisany](https://github.com/yisany)的定制版本, 基于[SpringBootCodeGenerator](https://github.com/moshowgame/SpringBootCodeGenerator)实现.

## Description

- √ 基于SpringBoot2+Freemarker+Bootstrap
- √ 以释放双手为目的
- √ 支持mysql/oracle/pgsql三大数据库
- √ 用DDL-SQL语句生成JPA/JdbcTemplate/Mybatis/MybatisPlus/BeetlSQL相关代码.

## Advantage

- 支持DDL SQL/INSERT SQL/SIMPLE JSON生成模式
- 自动记忆最近生成的内容，最多保留9个
- 提供众多通用模板，易于使用，复制粘贴加简单修改即可完成CRUD操作
- 支持特殊字符模板(`#`请用`井`代替;`$`请用`￥`代替)
- 根据comment=(mysql)或者comment on table(pgsql/oracle)生成类名注释
- BeanUtil提供一些基本对象的使用方法供COPY

## Update

| 更新日期 | 更新内容                                          |
| -------- | ------------------------------------------------- |
| 20200701 | 修复表注释为空导致的解析失败问题                  |
| 20200629 | sql解析底层换用Druid的SQL解析器, 支持Oracle的解析 |
| 20200503 | fork项目                                          |

## License

MIT

