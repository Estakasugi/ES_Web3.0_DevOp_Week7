"""
1122. Relative Sort Array
Given two arrays arr1 and arr2, the elements of arr2 are distinct, and all elements in arr2 are also in arr1.

Sort the elements of arr1 such that the relative ordering of items in arr1 are the same as in arr2. Elements that do not appear in arr2 should be placed at the end of arr1 in ascending order.

 

Example 1:

Input: arr1 = [2,3,1,3,2,4,6,7,9,2,19], arr2 = [2,1,4,3,9,6]
Output: [2,2,2,1,4,3,3,9,6,7,19]
Example 2:

Input: arr1 = [28,6,22,8,44,17], arr2 = [22,28,8,6]
Output: [22,28,8,6,17,44]
"""

class Solution(object):
    def relativeSortArray(self, arr1, arr2):
        """
        :type arr1: List[int]
        :type arr2: List[int]
        :rtype: List[int]
        """
        arr1EleCountDictionary = {}
        for i in range(len(arr1)):
            if arr1[i] in arr1EleCountDictionary:
                arr1EleCountDictionary[arr1[i]] += 1
            else:
                arr1EleCountDictionary[arr1[i]] = 1


        arr2PosDictionary = {}
        for i in range(len(arr2)):
            arr2PosDictionary[arr2[i]] = i


        nonArr2List = []
        for num in arr1:
            if num not in arr2PosDictionary:
                nonArr2List.append(num)
        nonArr2List.sort()


        arr2IncludeList = []
        for num in arr2:
            for i in range(arr1EleCountDictionary[num]):
                arr2IncludeList.append(num)



        return arr2IncludeList + nonArr2List
