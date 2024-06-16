def removeDuplicates(nums):
    """
    :type nums: List[int]
    :rtype: int
    """
    dupDictionary = {}
    dupCt = 0

    for i in range(len(nums)):
        if nums[i] in dupDictionary:
            nums[i] = 777
            dupCt += 1
        else:
            dupDictionary[nums[i]] = True

    nums.sort()

    for i in range(len(nums)):
        if nums[i] == 777:
            nums[i] = "_"


    return len(nums) - dupCt

arr = [0,0,1,1,1,2,2,3,3,4]
ans = removeDuplicates(arr)
print(ans, arr)
        