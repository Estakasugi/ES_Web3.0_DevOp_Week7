def removeDuplicates(nums):
    """
    :type nums: List[int]
    :rtype: int
    """
    dupDictionary = {}
    dupCt = 0
  

    j = 0 
    for i in range(len(nums)):
        if nums[i] in dupDictionary:
            dupCt += 1
        else:
            dupDictionary[nums[i]] = True
            nums[j] = nums[i]
            j += 1

    for i in range(dupCt):
        nums[i+j] = "_"

    return len(nums) - dupCt

arr = [0,0,1,1,1,2,2,3,3,4]
ans = removeDuplicates(arr)
print(ans, arr)
        