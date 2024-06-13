def removeElement(nums, val):
    """
    :type nums: List[int]
    :type val: int
    :rtype: int
    """
    popPos = []
    for i in range(len(nums)):
        if nums[i] == val:
            popPos.append(i)
    
    ans = len(nums) - len(popPos)
    
    print(popPos)
    for pos in popPos:
        nums[pos] = 777

    nums.sort()

    for i in range(len(popPos)):
        nums.pop()
    
    return ans
    


arr = [0,1,2,2,3,0,4,2]
ans = removeElement(arr, 2)
print(ans, arr)