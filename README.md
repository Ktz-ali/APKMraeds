## 遥辉APK报毒免杀处理分发系统公益版

## ★程序介绍

><p>一款用于对Android应用进行多重打包、签名随机化、代码混淆及加固处理的自动化系统。系统通过反编译与重编译APK技术，通过修改包名、签名、资源文件、Dex代码等元素，生成具有新特征的新APK，有效降低同一应用多次分发被识别为“病毒”或“恶意软件”的概率，从而减少被安全软件误报的风险。</p>

><p>系统支持多种云存储对接、多种加固方式、自定义处理规则与批量操作、自动化部署及多版本选择，适用于开发者及企业用户规避APK误报问题，提升应用分发成功率。</p>

---

## ★ 环境要求

所有版本均需满足以下标准服务器配置：

· 操作系统：CentOS 7.9
· Web服务器：Nginx 1.21
· 数据库：MySQL 5.7
· 硬件配置：2核CPU，2GB内存

---

## ★ 源码说明

· 本系统为自研技术方案，不依赖任何第三方防毒接口，保证处理流程的独立性与安全性。
· 自动处理误报毒，确保每次打包的APK独特无二。
· 支持无限用户管理与任务配额设置。
· 提供自动化部署脚本与视频部署教程与可视化任务状态监控。
· 系统无授权机制，支持二次开发，各版本提供完整源码及基础技术支持。

---

## ★ 适用场景

1. 开发者希望提高APK的下载率，避免因报毒造成用户流失。
2. 企业需要在内部应用中确保软件不被误判，保障顺利使用。

---

## ★ 部署教程

1. **上传部署包**  
   - 通过宝塔面板上传部署包至 `/www/wwwroot` 目录并解压

2. **创建站点**
   - 设置目录列表程序目录为 `/www/wwwroot/AliPack`

3. **数据库**  
   - 创建数据库：`apkgyb`
   - 用户名：`apkgyb`
   - 密码：`apkgyb`
   - 导入数据库文件：`AliGYB.sql`

4. **移动脚本文件**
   - 将xali.sh移动至宝塔根目录 `/root` 目录下

5. **终端执行脚本**
```
chmod +x xali.sh
./xali.sh

```


## ★ 演示截图

### 首次使用流程
![首次使用流程图](https://github.com/Ktz-ali/GithubToolKit/blob/main/流程图/1.首次使用流程图.jpg)

### 创建仓库流程
![创建仓库流程图](https://github.com/Ktz-ali/GithubToolKit/blob/main/流程图/2.创建仓库流程图.jpg)

### 跨平台同步流程
![跨平台同步流程图](https://github.com/Ktz-ali/GithubToolKit/blob/main/流程图/3.跨平台同步流程图.jpg)

### 功能菜单界面
![功能菜单界面图](https://github.com/Ktz-ali/GithubToolKit/blob/main/流程图/4.功能菜单界面图.jpg)

## ★ 下载地址

- 下载1：https://share.feijipan.com/s/duXlORXl

- 下载2：https://share.feijipan.com/s/lsXlNKih

## ★ 付费版本
如有更高需求请查看[付费版本](https://github.com/Ktz-ali/APKMraeds/blob/main/如有更高需求查看.md)

## ★ 技术支持
- 教程编写: 消失的阿力  
- 联系方式:  
- 📧 QQ: `1728031575`  
- 📱 WeChat: `Ali01021123`
- ⭐️ Github: `https://github.com/Ktz-ali`
- 🐟 闲鱼: `阿力_遥辉网络`
- 🔥 B站: `消失的阿力`
- ☀️ 互站: `https://www.huzhan.com/ishop53338`