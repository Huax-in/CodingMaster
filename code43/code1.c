#include <stdio.h>
#include <string.h>

#define TRUE 1
// 最大命令长度
#define MAXCMD 16

#define KEY_INSERT "insert"
#define KEY_SEARCH "search"
#define KEY_UPDATE "update"
#define KEY_DELETE "delete"
#define KEY_SAVE "save"
#define KEY_HELP "help"
#define KEY_SHOW "show"
#define KEY_QUIT "quit"

// 非法指令
#define OPCODE_ILLEGAL -1
// 插入
#define OPCODE_INSERT 0
// 搜索
#define OPCODE_SEARCH 1
// 修改
#define OPCODE_UPDATE 2
// 删除
#define OPCODE_DELETE 3
// 保存
#define OPCODE_SAVE 4
// 帮助
#define OPCODE_HELP 5
// 显示数据
#define OPCODE_SHOW 6
// 退出
#define OPCODE_QUIT 7

int getopcode(char* command);
int illegal();
int help();
int show();
int save();
int insert(char* data);
int search(char* data);
int update(char* data);
int delete (char* data);

int main(int argc, char* argv[]) {
    // 用于接收指令
    char command[MAXCMD] = {0};
    int opcode = -1;
    char data[MAXCMD] = {0};
    // 无限循环
    while (TRUE) {
        // 输出提示符
        printf("sms>");
        //输入命令
        scanf("%s", command);
        opcode = getopcode(command);
        if (opcode == OPCODE_ILLEGAL) {
            printf("Unsupported command!\n");
            continue;
        }
        if (opcode == OPCODE_QUIT) {
            printf("Bye!\n");
            break;
        }
        if (opcode == OPCODE_SAVE) {
            save();
        }
        if (opcode == OPCODE_HELP) {
            help();
        }
        if (opcode == OPCODE_SHOW) {
            show();
        }
        // data = command;
        scanf("%s", data);
        switch (opcode) {
            case OPCODE_INSERT:
                insert(data);
                break;
            case OPCODE_SEARCH:
                search(data);
                break;
            case OPCODE_UPDATE:
                update(data);
                break;
            case OPCODE_DELETE:
                delete (data);
                break;
            default:
                break;
        }
    }
    return 0;
}

int getopcode(char* command) {
    int opcode = OPCODE_ILLEGAL;
    if (strcmp(command, KEY_INSERT) == 0) {
        opcode = OPCODE_INSERT;
    }
    if (strcmp(command, KEY_SEARCH) == 0) {
        opcode = OPCODE_SEARCH;
    }
    if (strcmp(command, KEY_UPDATE) == 0) {
        opcode = OPCODE_UPDATE;
    }
    if (strcmp(command, KEY_DELETE) == 0) {
        opcode = OPCODE_DELETE;
    }
    if (strcmp(command, KEY_SAVE) == 0) {
        opcode = OPCODE_SAVE;
    }
    if (strcmp(command, KEY_HELP) == 0) {
        opcode = OPCODE_HELP;
    }
    if (strcmp(command, KEY_SHOW) == 0) {
        opcode = OPCODE_SHOW;
    }
    if (strcmp(command, KEY_QUIT) == 0) {
        opcode = OPCODE_QUIT;
    }
    return opcode;
}

int illegal() {
    return 0;
}
int help() {
    return 0;
}
int show() {
    return 0;
}
int save() {
    return 0;
}
int insert(char* data) {
    printf("insert data:%s\n", data);
    return 0;
}
int search(char* data) {
    return 0;
}
int update(char* data) {
    return 0;
}
int delete (char* data) {
    return 0;
}