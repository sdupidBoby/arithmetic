//: Playground - noun: a place where people can play

import UIKit

func Log<N>(message:N){
    let lineNumber:Int = #line
    print("line:\(lineNumber)-------->\(message)");
}
func print<N>(message:N){
    print("\(message)");
}

/*
 in-place操作，意思是所有的操作都是”就地“操作，不允许进行移动，或者称作“原位操作”，即不允许使用临时变量

 */

var srotArr: [Int] = [6, 5, 4, 3, 800, 1, 8, 7, 2, 4]
print(srotArr)

func c()->Void{
//    print(message: "冒泡----开始")
    print(bubbleSort(arr: srotArr))
//    print(message:  "冒泡----结束")
    
//    print(message: "选择----开始")
//    print(selectionSort(arr: srotArr))
//    print(message:  "选择----结束")
    
//    print(message: "插入----开始")
//    print(insertionSort(arr: srotArr))
//    print(message:  "插入----结束")
    
//    print(message: "归并----开始")
//    print(mergeSort(arr: srotArr))
//    print(message:  "归并----结束")
    
//    print(message: "快速----开始")
//    print(quickSort(list: &srotArr, low: 0, high: srotArr.count - 1))
//    print(message:  "快速----结束")

}

func bubbleSort(arr: Array<Int>) -> Array<Any>{// 冒泡 时间复杂度----O(n^2)
    let length = arr.count
    var arr = arr
    for i in 0..<(length-1) {
        print(message: "第\(i)轮冒泡：")
        for j in 0..<(length-1-i) {
            if (arr[j] > arr[j+1]) {   // 把最大的放到最后面
                print(message: "j:\(j)--> \(arr[j])>\(arr[j+1]): 冒泡")
                let temp = arr[j+1]  //(26 times)
                arr[j+1] = arr[j]
                arr[j]   = temp
            }else{
                print(message: "j:\(j)--> \(arr[j])<=\(arr[j+1]): 不冒泡")
            }
        }
        print(message: "第\(i)轮结果：\n \(arr)\n")
    }
    return arr
}


func selectionSort(arr: Array<Int>) -> Array<Any> {// 选择 时间复杂度----O(n^2)，空间复杂都很低O1 （👍）
    var arr = arr
    let len = arr.count
    var minIndex:Int,temp: Int
    for i in 0..<(len - 1) {
        print(message: "第\(i)轮选择：范围（\(i) <--> \(len-1)）")
        minIndex = i;
        for j in (i + 1)..<len {
            if (arr[j] < arr[minIndex]) {     // 寻找最小的数，放到最前面
                minIndex = j;                 // 将最小数的索引保存   (14 times)
            }
            print(message: "j-----> \(j)")
        }
        print("在后半部分乱序数列中，最小值：\(arr[minIndex]), 下标：\(minIndex)")
        temp = arr[i];
        arr[i] = arr[minIndex];
        arr[minIndex] = temp; // (9 times)
        print(message: "第\(i)轮结果：\n \(arr)\n")
    }
    return arr
}

func insertionSort(arr: Array<Int>) -> Array<Any> { //插入排序 时间复杂度----O(n^2)
    var arr = arr
    let len = arr.count
    var preIndex, current:Int
    for  i in 1..<len {
        print(message: "第\(i)轮插入：范围（0 <--> \(i)）")
        preIndex = i - 1
        current = arr[i]
        while (preIndex >= 0 && arr[preIndex] > current) {  //向前逐一比较，若前面的元素较大，就插入到之前
            arr[preIndex + 1] = arr[preIndex]  // (26 times)
            preIndex -= 1
        }
        arr[preIndex + 1] = current //把原值放入被交换了的位置  (9 times)
        print(message: "第\(i)轮结果：\n \(arr)\n")
    }
    return arr
}


func mergeSort(arr: Array<Int>) -> Array<Int> {  // 采用自上而下的递归方法. 归并.时间复杂度----O(nlog2n)
    //将数组中的每一个元素放入一个数组中
    var tempArray: Array<Array<Int>> = []
    for item in arr {
        var subArray: Array<Int> = []
        subArray.append(item)
        tempArray.append(subArray) // 拆分
    }
    
    //合并到一个数组为止
    while tempArray.count > 1 {
        print("最外层--------------：\(tempArray)")
        var i = 0
        while i < (tempArray.count - 1) { // 一层一层的合并
            print("将\(tempArray[i])与\(tempArray[i+1])合并")
            tempArray[i] = mergeArray(left: tempArray[i], right: tempArray[i + 1])
            tempArray.remove(at: i + 1) //移除被合并的元素
            print(message: "合并结果为：\(tempArray[i])\ntemp:\(tempArray), count:\(tempArray.count), i:\(i+1)\n")
            i += 1
        }
    }
    return tempArray.first!
}
/* 归并排序中的“并”--合并：将两个数组进行有序合并 */
func mergeArray(left: Array<Int>, right: Array<Int>) -> Array<Int> {
    var resultList: Array<Int> = []
    var leftIndex = 0
    var rightIndex = 0
    
    while leftIndex < left.count && rightIndex < right.count {
        if left[leftIndex] < right[rightIndex] {  //将小的元素加入到resultList里面
            resultList.append(left[leftIndex])
            leftIndex += 1
        } else {
            resultList.append(right[rightIndex])
            rightIndex += 1
        }
    }
    while leftIndex < left.count {
        resultList.append(left[leftIndex])
        leftIndex += 1
    }
    while rightIndex < right.count {
        resultList.append(right[rightIndex])
        rightIndex += 1
    }
    return resultList
}




/// - parameter list: 要排序的数组
/// - parameter low: 数组的上界
/// - parameter high:
private func quickSort(list: inout Array<Int>, low: Int, high: Int) { /// 快速排序 时间复杂度----O(nlog2n)
    if low < high {
        let mid = partition(list: &list, low: low, high: high)
        quickSort(list: &list, low: low, high: mid - 1)   //递归前半部分
        quickSort(list: &list, low: mid + 1, high: high)  //递归后半部分
    }
}

/// 将数组以第一个值为准分成两部分，前半部分比该值要小，后半部分比该值要大
///
/// - parameter list: 要二分的数组
/// - parameter low:  数组的下界
/// - parameter high: 数组的上界
///
/// - returns: 分界点
private func partition(list: inout Array<Int>, low: Int, high: Int) -> Int {
    var low = low
    var high = high
    let temp = list[low]
    print("low[\(low)]:\(list[low]), high[\(high)]:\(list[high])")
    while low < high {
        
        while low < high && list[high] >= temp {
            high -= 1
        }
        list[low] = list[high]
        
        while low < high && list[low] <= temp {
            low += 1
        }
        list[high] = list[low]
    }
    list[low] = temp
    print("mid[\(low)]:\(list[low])")
    print("\(list)\n")
    return low
}


c()
