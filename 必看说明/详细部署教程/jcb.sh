#!/bin/bash
# 遥辉APK报毒处理系统自动化部署脚本
# 作者：消失的阿力【B站&闲鱼同名】

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # 无颜色

# 初始化环境变量
TARGET_DIR="/www/wwwroot/AliPack/JCB"
CONFIG_FILE="${TARGET_DIR}/config/application.yml"

# 检查root权限
check_root() {
    if [ "$(id -u)" != "0" ]; then
        echo -e "${RED}错误：该脚本需要root权限执行！${NC}"
        exit 1
    fi
}

# 下载并卸载宝塔面板
baota_menu() {
    echo -e "${CYAN}正在下载宝塔面板卸载脚本...${NC}"
    wget -q --show-progress http://download.bt.cn/install/bt-uninstall.sh
    echo -e "${GREEN}卸载脚本下载成功，正在执行卸载...${NC}"
    bash bt-uninstall.sh
    echo -e "${GREEN}宝塔面板卸载过程已完成。${NC}"
}


# 安装JDK环境
install_jdk() {
    echo -e "${YELLOW}[1/5] 正在检查Java环境...${NC}"
    if java -version &>/dev/null; then
        echo -e "${BLUE}检测到已安装Java环境，跳过安装${NC}"
    else
        echo -e "${YELLOW}正在安装Java环境...${NC}"
        yum -y install java-1.8.0-openjdk.x86_64 || {
            echo -e "${RED}Java安装失败！请检查yum配置${NC}"
            exit 1
        }
        echo -e "${GREEN}Java环境安装成功！${NC}"
    fi
}

# 设置目录权限（新增校验逻辑）
set_permissions() {
    echo -e "${YELLOW}[2/5] 正在检查JCB目录权限...${NC}"
    # 检查目录是否存在
    if [ ! -d "$TARGET_DIR" ]; then
        echo -e "${RED}错误：目录 ${TARGET_DIR} 不存在！${NC}"
        exit 1
    fi
    # 检查权限和所有者
    CURRENT_PERM=$(stat -c %a "${TARGET_DIR}")
    CURRENT_OWNER=$(stat -c %U "${TARGET_DIR}")  
    if [[ "$CURRENT_PERM" == "777" && "$CURRENT_OWNER" == "root" ]]; then
        echo -e "${GREEN}检测到目录已是777权限且属于root用户，跳过权限设置${NC}"
        return
    fi
    echo -e "${YELLOW}正在设置JCB目录777权限...${NC}"
    # 排除.user.ini文件设置权限
    find "$TARGET_DIR" -path "${TARGET_DIR}/.user.ini" -prune -o -exec chmod 777 {} \;
    chown -R root:root "$TARGET_DIR"
    echo -e "${GREEN}目录权限设置完成！${NC}"
}

# 替换配置文件IP
replace_config_ip() {
    echo -e "${YELLOW}[3/5] 正在修改配置文件IP...${NC}"
    read -p "请输入服务器IP地址: " SERVER_IP

    # IP地址格式验证
    if ! [[ $SERVER_IP =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
        echo -e "${RED}错误：IP地址格式无效！${NC}"
        exit 1
    fi

    # 执行替换操作
    if sed -i "s/服务器/$SERVER_IP/g" "$CONFIG_FILE" &>/dev/null; then
        echo -e "${GREEN}配置文件更新成功！${NC}"
    else
        echo -e "${RED}错误：配置文件修改失败！${NC}"
        exit 1
    fi
}


# 启动应用程序
start_application() {
    echo -e "${YELLOW}[4/5] 正在启动应用程序...${NC}"
    cd "$TARGET_DIR" || exit 1
    sh start.sh &> /dev/null &
    echo -e "${GREEN}应用程序启动成功！${NC}"
}

# 关闭应用程序
start_gb() {
    echo -e "${YELLOW}[5/5] 正在关闭应用程序...${NC}"
    cd "$TARGET_DIR" && sh stop.sh
    echo -e "${GREEN}应用程序关闭成功！${NC}"
}


# 显示部署结果
show_result() {
    echo -e "${YELLOW}================= 部署完成 =================${NC}"
    echo -e "后台访问地址：http://${SERVER_IP}:8033"
    echo -e "默认管理员账号：${GREEN}admin${NC}"
    echo -e "默认管理员密码：${GREEN}123456${NC}"
    echo -e "${YELLOW}============================================${NC}"
    echo -e "${BLUE}提示：首次启动需要等待30秒或以上初始化时间再进入后台${NC}"
    echo -e "${BLUE}具体看首页的状态是否高低起伏CPU负载情况会变大${NC}"
    echo -e "${BLUE}安全组点修改再确定刷新端口看看是否正常点详细是否有AliJCB字眼${NC}"
    echo -e "${BLUE}提示：如无法进入后台就重新开放8033和3306端口重启程序${NC}"
    echo -e "${BLUE}作者：消失的阿力【闲鱼&B站同号】${NC}"
    echo -e "${BLUE}联系方式：QQ：1728031575 | 微信：Ali01021123${NC}"
}

# 主执行流程
main() {
    install_jdk
    set_permissions
    replace_config_ip
    start_application
    show_result
}

# 主菜单
main_menu() {
    echo -e "${BLUE}——————欢迎使用遥辉一键部署多功能脚本——————${NC}"
    echo -e "${YELLOW}使用须知：${NC}"
    echo -e "${YELLOW}1. 请先通过宝塔面板上传部署包到www/wwwroot目录并解压${NC}"
    echo -e "${YELLOW}2. 请先创建网站并设置目录为 /www/wwwroot/JCB${NC}"
    echo -e "${YELLOW}3. 请先创建数据库用户名 apkjcb 密码 alijcb${NC}"
    echo -e "${YELLOW}4. 导入数据库文件AliJCB.sql${NC}"
    echo -e "${YELLOW}5. 宝塔安全组防火墙添加端口8033 ${NC}"
    echo -e "${YELLOW}6. 以上全部创建完成后再使用脚本部署环境${NC}"
    echo -e "${YELLOW}确认脚本在root目录下并以root用户执行脚本${NC}\n"
    echo -e "${BLUE}选择操作：\n1) 一键部署环境\n2) 宝塔相关功能\n3) 启动程序\n4) 关闭程序\n5) 退出${NC}"
    read -p "请输入指令: " user_choice
    case $user_choice in
        1) main ;;
        2) baota_menu ;;
        3) start_application ;;
        4) start_gb ;;
        5) exit 0 ;;
        *) echo -e "${RED}无效选择${NC}" && main_menu ;;
    esac
}

# 启动主菜单循环显示
check_root
main_menu
