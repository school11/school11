### 1.3.0 -- 2013 XXXX ###

- [new] TMDiskCache: introduced concept of "trash" for rapid wipeouts


### 1.2.0 -- 2013 May 24 ###

- [new] TMDiskCache: added method `enumerateObjectsWithBlock:completionBlock:`
- [new] TMDiskCache: added method `enumerateObjectsWithBlock:`
- [new] TMDiskCache: added unit tests for the above
- [new] TMMemoryCache: added method `enumerateObjectsWithBlock:completionBlock:`
- [new] TMMemoryCache: added method `enumerateObjectsWithBlock:`
- [new] TMMemoryCache: added event block `didReceiveMemoryWarningBlock`
- [new] TMMemoryCache: added event block `didEnterBackgroundBlock`
- [new] TMMemoryCache: added boolean property `removeAllObjectsOnMemoryWarning`
- [new] TMMemoryCache: added boolean property `removeAllObjectsOnEnteringBackground`
- [new] TMMemoryCache: added unit tests for memory warning and app background blocks
- [del] TMCache: removed `cost` methods pending a solution for disk-based cost


### 1.1.2 -- 2013 May 13 ###

- [fix] TMCache: prevent `objectForKey:block:` from hitting the thread ceiling
- [new] TMCache: added a test to make sure we don't deadlock the queue


### 1.1.1 -- 2013 May 1 ###

- [fix] simplified appledoc arguments in podspec, updated doc script


### 1.1.0 -- 2013 April 29 ###

- [new] TMCache: added method `setObject:forKey:withCost:`
- [new] TMCache: documentation


### 1.0.3 -- 2013 April 27 ###

- [new] TMCache: added property `diskByteCount` (for convenience)
- [new] TMMemoryCache: `totalCost` now returned synchronously from queue
- [fix] TMMemoryCache: `totalCost` set to zero immediately after `removeAllObjects:`


### 1.0.2 -- 2013 April 26 ###

- [fix] TMCache: cache hits from memory will now update access time on disk
- [fix] TMDiskCache: set & remove methods now acquire a `UIBackgroundTaskIdentifier`
- [fix] TMDiskCache: will/didAddObject blocks actually get executed
- [fix] TMDiskCache: `trimToSize:` now correctly removes objects in order of size
- [fix] TMMemoryCache: `trimToCost:` now correctly removes objects in order of cost
- [new] TMDiskCache: added method `trimToSizeByDate:`
- [new] TMMemoryCache: added method `trimToCostByDate:`
- [new] TMDiskCache: added properties `willRemoveAllObjectsBlock` & `didRemoveAllObjectsBlock`
- [new] TMMemoryCache: added properties `willRemoveAllObjectsBlock` & `didRemoveAllObjectsBlock`
- [new] TMCache: added unit tests


### 1.0.1 -- 2013 April 23 ###

- added an optional "cost limit" to `TMMemoryCache`, including new properties and methods
- calling `[TMDiskCache trimToDate:]` with `[NSDate distantPast]` will now clear the cache
- calling `[TMDiskCache trimDiskToSize:]` will now remove files in order of access date
- setting the byte limit on `TMDiskCache` to 0 will no longer clear the cache (0 means no limit)
