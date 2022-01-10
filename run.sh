#!/bin/sh

#   Copyright (C) 2016 Deepin, Inc.
#
#   Author:     Li LongYu <lilongyu@linuxdeepin.com>
#               Peng Hao <penghao@linuxdeepin.com>

#               sirius <916108538@qq.com>

version_gt() { test "$(echo "$@" | tr " " "\n" | sort -V | head -n 1)" != "$1"; }

BOTTLENAME="Deepin-WXWork"
APPVER="3.1.12.6001deepin8"
EXEC_PATH="c:/Program Files/WXWork/WXWork.exe"
START_SHELL_PATH="/opt/deepinwine/tools/run_v4.sh"
export MIME_TYPE=""
export DEB_PACKAGE_NAME="com.qq.weixin.work.deepin"
export APPRUN_CMD="deepin-wine6-stable"
#export APPRUN_CMD="deepin-wine5"
DISABLE_ATTACH_FILE_DIALOG=""

export SPECIFY_SHELL_DIR=`dirname $START_SHELL_PATH`

ARCHIVE_FILE_DIR="/opt/apps/$DEB_PACKAGE_NAME/files"

export WINEDLLPATH=/opt/$APPRUN_CMD/lib:/opt/$APPRUN_CMD/lib64

export WINEPREDLL="$ARCHIVE_FILE_DIR/dlls"

# =======
WINEPREFIX="$HOME/.deepinwine/$BOTTLENAME"
WECOM_VER="3.1.23.6025"
WECOM_INSTALLER="WeCom"
WECOM_INSTALLER_PATH="c:/Program Files/${WECOM_INSTALLER}_${WECOM_VER}.exe"
# =======


OpenWinecfg()
{
    env WINEPREFIX=$WINEPREFIX $APPRUN_CMD winecfg
}

Run()
{
    if [ -z "$DISABLE_ATTACH_FILE_DIALOG" ];then
        export ATTACH_FILE_DIALOG=1
    fi
    
    if [ -n "$EXEC_PATH" ];then
        if [ ! -f "$WINEPREFIX/reinstalled" ];then
            # run installer
            env WINEDLLOVERRIDES="winemenubuilder.exe=d" $START_SHELL_PATH $BOTTLENAME $APPVER "$WECOM_INSTALLER_PATH" "$@"
            touch $WINEPREFIX/reinstalled
        else
    
            if [ -z "${EXEC_PATH##*.lnk*}" ];then
                $START_SHELL_PATH $BOTTLENAME $APPVER "C:/windows/command/start.exe" "/Unix" "$EXEC_PATH" "$@"
            else
                $START_SHELL_PATH $BOTTLENAME $APPVER "$EXEC_PATH" "$@"
            fi
        fi
    else
        $START_SHELL_PATH $BOTTLENAME $APPVER "uninstaller.exe" "$@"
    fi
}

HelpApp()
{
    echo " Extra Commands:"
    echo " winecfg        Open winecfg"
    echo " -h/--help      Show program help info"
}

if [ -z $1 ]; then
    Run "$@"
    exit 0
fi
case $1 in
    "winecfg")
        OpenWinecfg
        ;;
    "-h" | "--help")
        HelpApp
        ;;
    *)
        Run "$@"
        ;;
esac
exit 0

