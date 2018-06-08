//
//  ViewController.m
//  CommonAlgorithms
//
//  Created by shichenzhi on 2018/4/4.
//  Copyright © 2018年 sy. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

//初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *array = @[@(1),@(2),@(3),@(4),@(5),@(6),@(7),@(8)];
    NSInteger log = [self twoPointLookup:array target:6 lower:0 upper:7];
    NSLog(@"%ld",log);
}

/**
 二分查找

 @param array 需要查找的数组且必须为有序数组
 @param key 目标元素
 @param lower 数组起始下标
 @param upper 数组末尾下标
 @return 目标元素在数组的下标
 */
- (NSInteger)twoPointLookup:(NSArray *)array target:(NSInteger)key lower:(NSInteger)lower upper:(NSInteger)upper
{
    if (lower < upper) {
        //获取中间数组下标
        NSInteger middle = (lower+upper)/2;
        //与目标元素相等则直接返回
        if (key == [array[middle] integerValue]) {
            return middle;
        }
        //目标元素小于中间值
        else if (key < [array[middle] integerValue]) {
            //递归调用，起始下标为lower，末尾下标则改为middle-1
            return [self twoPointLookup:array target:key lower:lower upper:middle-1];
        }
        else {
            //递归调用，起始下标则改为middle+1，末尾下标为upper
            return [self twoPointLookup:array target:key lower:middle+1 upper:upper];
        }
    }
    else {
        return -1;
    }
}

//直接插入排序
- (void)insertSort:(NSMutableArray *)array
{
    for (int i = 1; i < array.count; i++) {
        int j = i;
        //记录第下个元素
        NSInteger temp = [array[i] integerValue];
        //进行升序排序
        while (j>0 && temp < [array[j-1] integerValue]) {
            //把大于temp的值放到temp的位置
            [array replaceObjectAtIndex:j withObject:array[j-1]];
            j--;
        }
        //然后把temp的值放在前面的位置
        [array replaceObjectAtIndex:j withObject:[NSNumber numberWithInteger:temp]];
    }
}

//简单选择排序
- (void)selectionSort:(NSMutableArray *)array
{
    for (int i = 0; i < array.count-1; i++) {
        for (int j = i+1; j < array.count; j++) {
            //进行升序排序
            if ([array[i] integerValue] > [array[j] integerValue]) {
                [self swap:array left:i right:j];
            }
        }
    }
}

//冒泡排序
- (void)bubbleSort:(NSMutableArray *)array
{
    //比较的轮数
    for (int i = 0; i < array.count-1; i++) {
        //每轮比较的次数
        for (int j = 0; j<array.count-1-i; j++) {
            //进行升序排序
            if ([array[j] integerValue] > [array[j+1] integerValue]) {
                //交换元素
                [self swap:array left:j right:j+1];
            }
        }
    }
}

- (void)sortArray:(NSMutableArray *)array left:(NSInteger)left right:(NSInteger)right
{
    if (left >= right) {
        return;
    }
    NSInteger i = left;
    NSInteger j = right;
    NSInteger key = [array[i] integerValue];
    
    while (i<j) {
        while (i<j && key <= [array[j] integerValue]) {
            j--;
        }
        [self swap:array left:i right:j];
        
        while (i<j && key >= [array[i] integerValue]) {
            i++;
        }
        [self swap:array left:j right:i];
    }
    
    [self sortArray:array left:left right:i-1];
    [self sortArray:array left:i+1 right:right];
}

//交换
- (void)swap:(NSMutableArray *)array left:(NSInteger)left right:(NSInteger)right
{
    NSNumber *temp;
    if (array != nil && array.count > 0) {
        temp = array[left];
        array[left] = array[right];
        array[right] = temp;
    }
}

/**
 快速排序

 @param array 需要排序的数据集合，必须是可变数组，因为不可变数组不能进行元素交换
 @param left 该数组的起始下标
 @param right 该数组的末尾下标
 */
- (void)fastSortingArray:(NSMutableArray *)array low:(NSInteger)left high:(NSInteger)right
{
    if (left >= right) {
        return;
    }
    NSInteger i = left;
    NSInteger j = right;
    NSInteger key = [array[left] integerValue];
    
    while (i<j) {
        while (i<j && key <= [array[j] integerValue]) {
            j--;
        }
        array[i] = array[j];
        
        while (i<j && key >= [array[i] integerValue]) {
            i++;
        }
        array[j] = array[i];
    }
    array[i] = [NSNumber numberWithInteger:key];
    
    [self fastSortingArray:array low:left high:i-1];
    [self fastSortingArray:array low:i+1 high:right];
}

@end
