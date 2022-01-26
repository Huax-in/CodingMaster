#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAXNAME 20
#define GPERROR -1

typedef struct student {
    unsigned int code;
    char name[MAXNAME];
    struct student *next;
} Student;

typedef struct stulist {
    Student* head;
    int count;
} StuList;

Student* createStudent();

int main(int argc, char* argv[]) {
    StuList stul;
    Student* stu;
    stul.head = createStudent();
    if (stul.head == NULL) {
        return GPERROR;
    }
    stul.count = 1;
    stu = stul.head;
    scanf("%d %s", &stu->code, stu->name);
    stu->next = createStudent();
    if (stu->next == NULL) {
        return GPERROR;
    } 
    stul.count++;
    stu = stu->next;
    scanf("%d %s", &stu->code, stu->name);
    stu = stul.head;
    for(int i = 0; i < stul.count; i++) {
        printf("StuList[%d]`s code is %d, ", i, stu->code);
        printf("name is %s\n", stu->name);
        stu = stu->next;
    }
    return 0;
}

Student* createStudent() {
    Student* stu;
    stu = (Student*)malloc(sizeof(Student));
    stu->code = 0;
    memset(stu->name, 0, MAXNAME);
    stu->next = NULL;
    return stu;
}