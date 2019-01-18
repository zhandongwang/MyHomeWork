//
//  Queue.cpp
//  FastAlgorithm
//
//  Created by 凤梨 on 2018/12/22.
//  Copyright © 2018年 2dfire. All rights reserved.
//

#include "Queue.hpp"
#include <stack>
using namespace std;

template <typename T>
class CQueue {
public:
    CQueue(void);
    ~CQueue(void);
    
    void appendTail(const T & node);
    T deleteHead();
    
private:
    stack<T> stack1;
    stack<T> stack2;
};

struct ListNode {
     int val;
     ListNode *next;
     ListNode(int x) : val(x), next(NULL) {}
 };

class Solution {
public:
    ListNode* deleteDuplicates(ListNode* head) {
        if (!head) {
            return NULL;
        }
        if (head->next == NULL) {
            return head;
        }
        ListNode *current = head;
        while (current->next != NULL) {
            if (current->next->val == current->val) {
                current->next = current->next->next;
            } else {
                current = current->next;
            }
        }
        return head;
    }
};
