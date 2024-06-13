def removeElement(nums, val):
    """
    :type nums: List[int]
    :type val: int
    :rtype: int
    """
    orgLen = len(nums)
    rmvLen = 0
    for i in range(len(nums)):
        if nums[i] == val:
            nums[i] = "_"
            rmvLen += 1
    
    for i in range(rmvLen):
        nums.remove("_")
        nums.append("_")

    return orgLen - rmvLen
    

    


arr = [0,1,2,2,3,0,4,2]
ans = removeElement(arr, 2)
print(ans, arr)