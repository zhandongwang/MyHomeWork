//
//  main.cpp
//  FastAlgorithm
//
//  Created by 凤梨 on 2018/12/12.
//  Copyright © 2018年 2dfire. All rights reserved.
//

#include <iostream>
using namespace std;
void testFindValue();
int reverse(int x);

int main(int argc, const char * argv[]) {
    // insert code here...
    cout << "Hello, World!\n";
//    testFindValue();
    
    return 0;
}

int reverse(int x) {
    int rev = 0;
    while (x != 0) {
        int pop = x % 10;
        x /= 10;
        if (rev > INT_MAX/10 || (rev == INT_MAX/10 && pop > 7)) {
            return 0;
        }
        if (rev > INT_MIN/10 || (rev == INT_MIN/10 && pop < -8)) {
            return 0;
        }
    }
    return rev;
}


//面试题3:二维数组中查找
bool findValue(int* matrix, int rows, int columns, int number) {
    bool found = false;
    
    if (matrix != NULL && rows > 0 && columns > 0) {
        int row = 0;
        int column =  columns - 1;
        
        while(row < rows && column > 0){
            if (matrix[row * columns + column] == number) {
                found = true;
                cout << "Found in (" << row << ","<< column << ")";
                break;
            }
            else if(matrix[row * columns + column] > number) {
                --column;
            } else {
                ++row;
            }
        }
    }
    return found;
}

void testFindValue() {
    int matrix[4][4] = {{1,2,8,9},{2,4,9,12},{4,7,10,13},{6,8,11,15}};
    bool ret =  findValue(matrix[0], 4, 4, 9);
    if (!ret) {
        cout << "Not found" << endl;
    }
}

//面试题4:替换空格
void replaceBlank(char string[], int length) {
    if (string == NULL || length <= 0) {
        return;
    }
    int originalLength = 0;
    int numberOfBlank = 0;
    int i = 0;
    while (string[i] != '\0') {
        ++originalLength;
        if (string[i] == ' ') {
            ++numberOfBlank;
        }
        ++i;
    }
    int newLength = originalLength + numberOfBlank * 2;
    int indexOfOriginal = originalLength;
    int indexOfNew = newLength;
    
    while (indexOfOriginal > 0 && indexOfNew > indexOfOriginal) {
        if (string[indexOfOriginal] == ' ') {
            string[indexOfNew--] = '0';
            string[indexOfNew--] = '2';
            string[indexOfNew--] = '\%';
        } else {
            string[indexOfNew--] = string[indexOfOriginal];
        }
        --indexOfOriginal;

    }
}

void testReplaceBlank() {
    char str[15] = "a b c d";
    replaceBlank(str,20);
    cout << str << endl;
}
