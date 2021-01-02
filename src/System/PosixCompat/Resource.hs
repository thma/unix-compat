{-# LANGUAGE CPP #-}
module System.PosixCompat.Resource (
    ResourceLimit(..), ResourceLimits(..), Resource(..),
    getResourceLimit,
    setResourceLimit
) where

#ifndef mingw32_HOST_OS

import System.Posix.Resource

#else

data Resource
  = ResourceCoreFileSize
  | ResourceCPUTime
  | ResourceDataSize
  | ResourceFileSize
  | ResourceOpenFiles
  | ResourceStackSize
  | ResourceTotalMemory
  deriving Eq

data ResourceLimits
  = ResourceLimits { softLimit, hardLimit :: ResourceLimit }
  deriving Eq

data ResourceLimit
  = ResourceLimitInfinity
  | ResourceLimitUnknown
  | ResourceLimit Integer
  deriving Eq

getResourceLimit :: Resource -> IO ResourceLimits
getResourceLimit _res = do
  print $ "getResourceLimit"
  return ResourceLimits {softLimit = ResourceLimitInfinity, hardLimit = ResourceLimitInfinity}

setResourceLimit :: Resource -> ResourceLimits -> IO ()
setResourceLimit _res _limits = do
  print $ "setResourceLimit"
  return ()

#endif